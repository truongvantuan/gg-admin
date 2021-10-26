package ggadmin.repository.ums;

import ggadmin.model.ums.Permission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Set;

@Repository
@Transactional
public interface PermissionRepository extends JpaRepository<Permission, Long> {

    Set<Permission> getAllByIdIs(Long adminId);

    @Query(value = "SELECT P.* FROM ums.admin_role_relation ar LEFT JOIN ums.role r ON ar.role_id = r.ID LEFT JOIN ums.role_permission_relation rp ON r.ID = rp.role_id LEFT JOIN ums.permission P ON rp.permission_id = P.ID WHERE ar.admin_id = :id AND P.ID IS NOT NULL AND P.ID NOT IN ( SELECT P.ID FROM ums.admin_permission_relation pr LEFT JOIN ums.permission P ON pr.permission_id = P.ID WHERE pr.TYPE = - 1 AND pr.admin_id = :id) UNION SELECT P.* FROM ums.admin_permission_relation pr LEFT JOIN ums.permission P ON pr.permission_id = P.ID WHERE pr.TYPE = 1 AND pr.admin_id = :id", nativeQuery = true)
    List<Permission> getPermissionsByAdminId(@Param("id") Long adminId);
}
