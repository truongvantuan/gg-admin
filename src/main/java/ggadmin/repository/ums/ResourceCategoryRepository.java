package ggadmin.repository.ums;

import ggadmin.model.ums.ResourceCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ResourceCategoryRepository extends JpaRepository<ResourceCategory, Long>, JpaSpecificationExecutor<ResourceCategory> {

}
