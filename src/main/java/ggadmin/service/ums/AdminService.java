package ggadmin.service.ums;

import ggadmin.dto.AdminDTO;
import ggadmin.dto.PermissionDTO;
import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Permission;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;
import java.util.Optional;
import java.util.Set;

public interface AdminService extends UserDetailsService {

    Optional<Admin> getAdminByUsername(String username);

    Admin register(AdminDTO adminDto); // đăng ký tài khoản admin

    String login(String username, String password); // đăng nhập admin với username/password

    //    Set<PermissionDTO> getPermissions(Long adminId);
    List<Permission> getPermissions(Long adminId);

}
