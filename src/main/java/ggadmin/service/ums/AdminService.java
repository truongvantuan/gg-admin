package ggadmin.service.ums;

import ggadmin.dto.ums.AdminDTO;
import ggadmin.dto.ums.AdminInfoDTO;
import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Resource;
import org.springframework.data.domain.Page;
import org.springframework.security.core.userdetails.UserDetailsService;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;
import java.util.List;
import java.util.Optional;

public interface AdminService extends UserDetailsService {

    Optional<Admin> getAdminByUsername(String username);

    Admin register(Admin admin); // đăng ký tài khoản admin

    String login(String username, String password); // đăng nhập admin với username/password

    List<Resource> getResources(Long adminId);

    void saveLoginLog(Long adminId, HttpServletRequest request);

    AdminInfoDTO getAdminInfo(Principal principal);

    Page<Admin> getAdminPage(Integer pageNum, Integer pageSize);

    Page<Admin> getAdminPage(Integer pageNum, Integer pageSize, String keyword);

    void delete(Long adminId);

    boolean updateRole(Long adminId, List<Long> rolesIds);

    boolean update(Long adminId, AdminDTO adminDTO);

    boolean updateStatus(Long adminId, Integer status);
}
