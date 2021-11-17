package ggadmin.service.ums.impl;

import ggadmin.common.utils.JwtTokenUtil;
import ggadmin.dto.ums.AdminDTO;
import ggadmin.dto.ums.AdminInfoDTO;
import ggadmin.dto.ums.AdminUserDetails;
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
        // 1. Tải Admin từ database, nếu không có ném ngoại lệ UsernameNotFoundException
        // 2. Chuyển Admin lấy được thành AdminUserDetails chứa admin và permission -> trả về AdminUserDetails
        Optional<Admin> adminOptional = adminRepository.getAdminByUsername(username);
        if (adminOptional.isEmpty()) {
            throw new UsernameNotFoundException("Admin with username: " + username + " not found!");
        }
        Admin admin = adminOptional.get();
        List<Resource> resourceList = getResources(admin.getId());
        return new AdminUserDetails(admin, resourceList);
    }

    @Override
    public Admin register(Admin admin) {
        if (adminRepository.getAdminByUsername(admin.getUsername()).isPresent()) {
            throw new AdminExistException("Người dùng đã được đăng ký!");
//            throw new RuntimeException("Người dùng đã được đăng ký!");
        }
//        Admin admin = adminDto.toAdmin();
        admin.setCreateTime(new Date());
//        admin.setStatus(1);
        String encodePassword = passwordEncoder.encode(admin.getPassword());
        admin.setPassword(encodePassword);
        return adminRepository.save(admin);
    }

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
     * Permission đã lưu vào database sẽ được lấy ra theo ID của Admin sử hữu.
     * Các giá trị Permissions này sẽ đem so sánh với SpEL (hasAuthority) cấu hình tại Controller method.
     * Nếu trùng Admin tương ứng sẽ có quyền truy cập (request đi qua filter)
     *
     * @param adminId
     * @return
     */
    @Override
    public List<Resource> getResources(Long adminId) {
        return resourceRepository.getResourcesByAdminId(adminId);
    }

    /**
     * Lưu lịch sử đăng nhập dựa trên adminId, các thông tin từ client được lấy từ request.
     *
     * @param adminId admin đăng nhập
     * @param request request dùng đăng nhập
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
        // Lấy username đã đăng nhập, xác thực thành công từ Principal
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
        --pageNum; // JPA đếm trang từ 0, cần giảm thêm 1
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
        // Kiểm tra người dùng đổi password không? Khác 60 ký tự đồng nghĩa đã đổ password
        if (adminDTO.getPassword().length() != 60) { // password được băm thành string 60 ký tự
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
