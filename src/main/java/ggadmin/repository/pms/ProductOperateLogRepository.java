package ggadmin.repository.pms;

import ggadmin.model.pms.ProductOperateLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ProductOperateLogRepository extends JpaRepository<ProductOperateLog, Long>, JpaSpecificationExecutor<ProductOperateLog> {

}
