package ggadmin.service.ums.impl;

import ggadmin.model.ums.Permission;
import ggadmin.service.ums.AdminService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class AdminServiceImplTest {

    @Autowired
    private AdminService adminService;

    @Test
    void test() {
        assertThat(adminService).isNotNull();
        List<Permission> permissions = adminService.getPermissions(1L);
        System.out.println(permissions.size());
        System.out.println(permissions.get(0).toString());
    }
}
