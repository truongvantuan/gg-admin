package ggadmin.repository.ums;

import ggadmin.model.ums.Permission;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class PermissionRepositoryTest {

    @Autowired
    PermissionRepository repository;

    @Test
    void test() {
        assertThat(repository).isNotNull();
        Set<Permission> permissions = repository.getAllByIdIs(1L);
        System.out.println(permissions.size());
    }

    @Test
    void test1() {
        List<Permission> permissions = repository.getPermissionsByAdminId(1L);
        System.out.println(permissions.size());
        System.out.println(permissions.get(0).toString());
    }
}
