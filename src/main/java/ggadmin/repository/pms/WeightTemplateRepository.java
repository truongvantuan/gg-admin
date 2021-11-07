package ggadmin.repository.pms;

import ggadmin.model.pms.WeightTemplate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface WeightTemplateRepository extends JpaRepository<WeightTemplate, Long>, JpaSpecificationExecutor<WeightTemplate> {

}
