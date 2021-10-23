package ggadmin.repository.ums;

import ggadmin.model.ums.Permission;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PermissionRepository extends JpaRepository<Permission, Long> {
}
