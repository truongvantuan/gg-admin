package ggadmin.service.ums.impl;

import ggadmin.common.utils.JwtTokenUtil;
import ggadmin.dto.ums.AdminDTO;
import ggadmin.dto.ums.AdminInfoDTO;
import ggadmin.dto.ums.AdminUserDetails;
import ggadmin.dto.ums.mapper.AdminMapper;
import ggadmin.exception.ums.AdminExistException;
import ggadmin.model.ums.*;
import ggadmin.repository.ums.*;
import ggadmin.service.ums.AdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class AdminServiceImpl implements AdminService {

    private static final Logger LOGGER = LoggerFactory.getLogger(AdminServiceImpl.class);

    @Value("${jwt.tokenHead}")
    String tokenHead;

    @Autowired
    private AdminRepository adminRepository;
    @Autowired
    private ResourceRepository resourceRepository;
    @Autowired
    private UserDetailsService userDetailsService;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private AdminLoginLogRepository adminLoginLogRepository;
    @Autowired
    private MenuRepository menuRepository;
    @Autowired
    private RoleRepository roleRepository;

    @Override
    public Optional<Admin> getAdminByUsername(String username) {
        return adminRepository.getAdminByUsername(username);
    }

    @Override
    public UserDetails loadUserByUsername(String username) {
        // 1. T???i Admin t??? database, n???u kh??ng c?? n??m ngo???i l??? UsernameNotFoundException
        // 2. Chuy???n Admin l???y ???????c th??nh AdminUserDetails ch???a admin v?? permission -> tr??? v??? AdminUserDetails
        Optional<Admin> adminOptional = adminRepository.getAdminByUsername(username);
        if (adminOptional.isEmpty()) {
            throw new UsernameNotFoundException("Admin with username: " + username + " not found!");
        }
        Admin admin = adminOptional.get();
        List<Resource> resourceList = getResources(admin.getId());
        return new AdminUserDetails(admin, resourceList);
    }

    @Override
    public Admin register(AdminDTO adminDTO) {
        if (adminRepository.getAdminByUsername(adminDTO.getUsername()).isPresent()) {
            throw new AdminExistException("Ng?????i d??ng ???? ???????c ????ng k??!");
//            throw new RuntimeException("Ng?????i d??ng ???? ???????c ????ng k??!");
        }
        Admin admin = AdminMapper.INSTANCE.toAdminEntity(adminDTO);
//        admin.setCreateTime(new Date());
//        admin.setStatus(1);
        String encodePassword = passwordEncoder.encode(admin.getPassword());
        admin.setPassword(encodePassword);
        return adminRepository.save(admin);
    }

/*    @Override
    public Admin register(Admin admin) {
        if (adminRepository.getAdminByUsername(admin.getUsername()).isPresent()) {
            throw new AdminExistException("Ng?????i d??ng ???? ???????c ????ng k??!");
//            throw new RuntimeException("Ng?????i d??ng ???? ???????c ????ng k??!");
        }
//        Admin admin = adminDto.toAdmin();
        admin.setCreateTime(new Date());
//        admin.setStatus(1);
        String encodePassword = passwordEncoder.encode(admin.getPassword());
        admin.setPassword(encodePassword);
        return adminRepository.save(admin);
    }*/

    @Override
    @Transactional
    public String login(String username, String password) {
        String token = null;
        try {
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);
            if (!passwordEncoder.matches(password, userDetails.getPassword())) {
                throw new BadCredentialsException("Incorrect username/password!");
            }
            adminRepository.saveLoginTime(new Date(), username);
            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(authentication);
            token = jwtTokenUtil.generateToken(userDetails);
        } catch (AuthenticationException e) {
            LOGGER.warn("Login failed: " + e.getMessage());
        }
        return token;
    }

    /**
     * Permission ???? l??u v??o database s??? ???????c l???y ra theo ID c???a Admin s??? h???u.
     * C??c gi?? tr??? Permissions n??y s??? ??em so s??nh v???i SpEL (hasAuthority) c???u h??nh t???i Controller method.
     * N???u tr??ng Admin t????ng ???ng s??? c?? quy???n truy c???p (request ??i qua filter)
     *
     * @param adminId
     * @return
     */
    @Override
    public List<Resource> getResources(Long adminId) {
        return resourceRepository.getResourcesByAdminId(adminId);
    }

    /**
     * L??u l???ch s??? ????ng nh???p d???a tr??n adminId, c??c th??ng tin t??? client ???????c l???y t??? request.
     *
     * @param adminId admin ????ng nh???p
     * @param request request d??ng ????ng nh???p
     */
    @Override
    public void saveLoginLog(Long adminId, HttpServletRequest request) {
        AdminLoginLog adminLoginLog = AdminLoginLog.builder()
                .adminId(adminId)
                .createTime(new Date())
                .ip(request.getRemoteHost())
                .address(request.getRemoteAddr())
                .userAgent(request.getHeader("User-Agent")).build();
        adminLoginLogRepository.save(adminLoginLog);
    }

    @Override
    public AdminInfoDTO getAdminInfo(Principal principal) {
        // L???y username ???? ????ng nh???p, x??c th???c th??nh c??ng t??? Principal
        String username = principal.getName();
        Admin admin = adminRepository.getAdminByUsername(username).get();
        List<Role> roleList = roleRepository.getAllByAdminsIs(admin);
        List<String> roles = roleList.stream()
                .map(Role::getName)
                .collect(Collectors.toList());
        List<Menu> menus = menuRepository.getAllByRolesIn(roleList);
        return AdminInfoDTO.builder()
                .username(username)
                .icon(admin.getIcon())
                .roles(roles)
                .menus(menus)
                .build();
    }

    @Override
    public Page<Admin> getAdminPage(Integer pageNum, Integer pageSize) {
        --pageNum; // JPA ?????m trang t??? 0, c???n gi???m th??m 1
        Pageable paging = PageRequest.of(pageNum, pageSize);
        Page<Admin> adminPage = adminRepository.findAll(paging);
        adminPage.getContent();
        return adminRepository.findAll(paging);
    }

    @Override
    public Page<Admin> getAdminPage(Integer pageNum, Integer pageSize, String keyword) {
        --pageNum;
        Pageable paging = PageRequest.of(pageNum, pageSize);
        return adminRepository.findAllByUsernameContainingIgnoreCase(keyword, paging);
    }

    @Override
    public void delete(Long adminId) {
        adminRepository.deleteById(adminId);
    }

    @Override
    public boolean updateRole(Long adminId, List<Long> rolesIds) {
        Admin admin = adminRepository.getById(adminId);
        boolean check = true;
        Set<Role> roleSet = new HashSet<>();
        List<Role> roleList = rolesIds.stream()
                .map(roleId -> roleRepository.getById(roleId))
                .collect(Collectors.toList());
        roleSet.addAll(roleList);
        admin.setRoles(roleSet);
        try {
            adminRepository.save(admin);
        } catch (Exception e) {
            check = false;
        }
        return check;
    }

    @Override
    public boolean update(Long adminId, AdminDTO adminDTO) {
        Admin admin = adminRepository.getById(adminId);
        // Ki???m tra ng?????i d??ng ?????i password kh??ng? Kh??c 60 k?? t??? ?????ng ngh??a ???? ????? password
        if (adminDTO.getPassword().length() != 60) { // password ???????c b??m th??nh string 60 k?? t???
            String encodePassword = passwordEncoder.encode(adminDTO.getPassword());
            admin.setPassword(encodePassword);
        }
        admin.setUsername(adminDTO.getUsername());
        admin.setNickName(adminDTO.getNickName());
        admin.setEmail(adminDTO.getEmail());
        admin.setNote(adminDTO.getNote());
        admin.setStatus(adminDTO.getStatus());
        boolean isSaved = true;
        try {
            adminRepository.save(admin);
        } catch (Exception e) {
            isSaved = false;
        }
        return isSaved;
    }

    @Override
    public boolean updateStatus(Long adminId, Integer status) {
        Admin adminToUpdate = adminRepository.getById(adminId);
        adminToUpdate.setStatus(status);
        boolean isSuccess = true;
        try {
            adminRepository.save(adminToUpdate);
        } catch (Exception e) {
            isSuccess = false;
        }
        return isSuccess;
    }
}
