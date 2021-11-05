package ggadmin.repository.pms;

import ggadmin.model.pms.ProductLadder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ProductLadderRepository extends JpaRepository<ProductLadder, Long>, JpaSpecificationExecutor<ProductLadder> {

}
