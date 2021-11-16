package ggadmin.repository.ums;

import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Role;
import ggadmin.service.ums.AdminService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Set;

@SpringBootTest
class RoleRepositoryTest {

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private AdminService adminService;

    @Test
    void test() {
        Admin admin = adminService.getAdminByUsername("admin").get();
        List<Role> roles = roleRepository.getAllByAdminsIs(admin);
        for (Role role : roles) {
            System.out.println(role.getName());
        }
    }
}
