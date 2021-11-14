package ggadmin.repository.ums;

import ggadmin.model.ums.AdminLoginLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface AdminLoginLogRepository extends JpaRepository<AdminLoginLog, Long>, JpaSpecificationExecutor<AdminLoginLog> {

}
