package ggadmin.service.ums.impl;

import ggadmin.common.utils.JwtTokenUtil;
import ggadmin.dto.AdminDTO;
import ggadmin.dto.AdminUserDetails;
import ggadmin.exception.ums.AdminExistException;
import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Permission;
import ggadmin.repository.ums.AdminRepository;
import ggadmin.repository.ums.PermissionRepository;
import ggadmin.service.ums.AdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class AdminServiceImpl implements AdminService {

    private static final Logger LOGGER = LoggerFactory.getLogger(AdminServiceImpl.class);

    @Value("${jwt.tokenHead}")
    String tokenHead;

    @Autowired
    private AdminRepository adminRepository;
    @Autowired
    private PermissionRepository permissionRepository;
    @Autowired
    private UserDetailsService userDetailsService;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public Optional<Admin> getAdminByUsername(String username) {
        return adminRepository.getAdminByUsername(username);
    }

    @Override
    public UserDetails loadUserByUsername(String username) {
        // 1. Load admin from database, if not found throw exception UsernameNotFoundException
        // 2. Convert/Wrap admin to AdminUserDetails object and return it.
        Optional<Admin> adminOptional = adminRepository.getAdminByUsername(username);
        if (adminOptional.isEmpty()) {
            throw new UsernameNotFoundException("Admin with username: " + username + " not found!");
        }
        Admin admin = adminOptional.get();
        List<Permission> permissions = getPermissions(admin.getId());
        return new AdminUserDetails(admin, permissions);
    }

    @Override
    public Admin register(AdminDTO adminDto) {
        if (adminRepository.getAdminByUsername(adminDto.getUsername()).isPresent()) {
            throw new AdminExistException();
//            throw new RuntimeException("Người dùng đã được đăng ký!");
        }
        Admin admin = adminDto.toAdmin();
        admin.setCreateTime(new Date());
        admin.setStatus(1);
        String encodePassword = passwordEncoder.encode(admin.getPassword());
        admin.setPassword(encodePassword);
        return adminRepository.save(admin);
    }

    @Override
    public String login(String username, String password) {
        String token = null;
        try {
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);
            if (!passwordEncoder.matches(password, userDetails.getPassword())) {
                throw new BadCredentialsException("Incorrect password");
            }
            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(authentication);
            token = jwtTokenUtil.generateToken(userDetails);
        } catch (AuthenticationException e) {
            LOGGER.warn("Login failed: " + e.getMessage());
        }
        return token;
    }

    @Override
    public List<Permission> getPermissions(Long adminId) {
        return permissionRepository.getPermissionsByAdminId(adminId);
    }

}
