package ggadmin.service.ums;

import ggadmin.dto.ums.RoleDTO;
import ggadmin.model.ums.Role;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface RoleService {

    List<Role> getAllRole();

    List<Role> getRolesByAdminId(Long adminId);

    Page<Role> getRolePage(Integer pageNum, Integer pageSize);

    Page<Role> getRolePage(String keyword, Integer pageNum, Integer pageSize);

    boolean updateStatus(Long roleId, Integer roleStatus);

    boolean create(RoleDTO roleDTO);
}
