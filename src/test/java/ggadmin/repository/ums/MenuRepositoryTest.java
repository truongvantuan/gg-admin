package ggadmin.repository.ums;

import ggadmin.model.ums.Menu;
import ggadmin.model.ums.Role;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Collections;
import java.util.List;
import java.util.Set;

@SpringBootTest
class MenuRepositoryTest {

    @Autowired
    MenuRepository menuRepository;
    @Autowired
    RoleRepository roleRepository;


}
