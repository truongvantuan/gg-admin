package ggadmin.repository.ums;

import ggadmin.model.ums.Permission;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class PermissionRepositoryTest {

    @Autowired
    PermissionRepository repository;

    @Test
    void test() {
        assertThat(repository).isNotNull();
        List<Permission> permissions = repository.getPermissionsByAdminId(1L);
        assertThat(permissions).hasSize(9);
    }

}
