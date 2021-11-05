package ggadmin.repository.pms;

import ggadmin.model.pms.ProductFullReduction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ProductFullReductionRepository extends JpaRepository<ProductFullReduction, Void>, JpaSpecificationExecutor<ProductFullReduction> {

}
