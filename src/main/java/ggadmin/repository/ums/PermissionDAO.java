package ggadmin.repository.ums;

import ggadmin.model.ums.Permission;

import java.util.List;

public interface PermissionDAO {

    List<Permission> getPermissionsByAdminID(Long adminId);
}
