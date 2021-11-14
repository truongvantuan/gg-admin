package ggadmin.service.ums;

import ggadmin.dto.AdminDTO;
import ggadmin.dto.PermissionDTO;
import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Permission;
import ggadmin.model.ums.Resource;
import org.springframework.security.core.userdetails.UserDetailsService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Optional;
import java.util.Set;

public interface AdminService extends UserDetailsService {

    Optional<Admin> getAdminByUsername(String username);

    Admin register(AdminDTO adminDto); // đăng ký tài khoản admin

    String login(String username, String password); // đăng nhập admin với username/password

    //    Set<PermissionDTO> getPermissions(Long adminId);
    List<Resource> getResources(Long adminId);

    void saveLoginLog(Long adminId, HttpServletRequest request);

}
