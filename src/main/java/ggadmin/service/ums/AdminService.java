package ggadmin.service.ums;

import ggadmin.dto.AdminDto;
import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Permission;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;
import java.util.Optional;

public interface AdminService extends UserDetailsService {

    Optional<Admin> getAdminByUsername(String username);

    Admin register(AdminDto adminDto); // đăng ký tài khoản admin

    String login(String username, String password); // đăng nhập admin với username/password

    List<Permission> getPermissions(Long adminId);
}
