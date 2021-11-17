package ggadmin.service.ums.impl;

import ggadmin.model.ums.Resource;
import ggadmin.service.ums.AdminService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class AdminServiceImplTest {

    @Autowired
    private AdminService adminService;

    @Test
    void test() {
        assertThat(adminService).isNotNull();
        List<Resource> resources = adminService.getResources(3L);
        System.out.println(resources.size());
        System.out.println(resources.get(0).toString());
    }

}
