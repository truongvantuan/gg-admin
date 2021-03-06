package ggadmin.repository.ums;

import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Menu;
import ggadmin.model.ums.Role;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Set;

public interface RoleRepository extends JpaRepository<Role, Long>, JpaSpecificationExecutor<Role> {

    List<Role> getAllByAdminsIs(Admin admin);

    Page<Role> findAllByNameContainingIgnoreCase(String keyword, Pageable page);

}
