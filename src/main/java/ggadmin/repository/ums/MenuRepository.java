package ggadmin.repository.ums;

import ggadmin.model.ums.Menu;
import ggadmin.model.ums.Role;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface MenuRepository extends JpaRepository<Menu, Long>, JpaSpecificationExecutor<Menu> {

    List<Menu> getAllByRolesIn(List<Role> role);

    List<Menu> getAllByParentMenuIdIs(Long parentId);

    Page<Menu> getAllByParentMenuIdIs(Long parentId, Pageable pageable);

}
