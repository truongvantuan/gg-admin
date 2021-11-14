package ggadmin.repository.ums;

import ggadmin.model.ums.Resource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ResourceRepository extends JpaRepository<Resource, Long>, JpaSpecificationExecutor<Resource> {

    @Query(value = "SELECT R.* FROM ums.admin LEFT JOIN ums.admin_role_relation ON admin.id = admin_role_relation.admin_id LEFT JOIN ums.role ON admin_role_relation.role_id = role.id LEFT JOIN ums.role_resource_relation ON role.id = role_resource_relation.role_id LEFT JOIN ums.resource R ON role_resource_relation.resource_id = R.id WHERE admin.id = :id", nativeQuery = true)
    List<Resource> getResourcesByAdminId(@Param("id") Long adminId);
}
