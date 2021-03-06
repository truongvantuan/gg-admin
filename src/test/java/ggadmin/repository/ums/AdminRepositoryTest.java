package ggadmin.repository.ums;

import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class AdminRepositoryTest {

    @Autowired
    AdminRepository adminRepository;

    @Autowired
    ResourceRepository resourceRepository;

    @Test
    void selectAdminTest() {
        List<Admin> adminList = adminRepository.selectAllAdmin();
        for (Admin ad : adminList) {
            System.out.println(ad.toString());
        }
    }

    @Test
    void getResourceByAdminId() {
        List<Resource> resourceList = resourceRepository.getResourcesByAdminId(3L);
        for (Resource resource : resourceList) {
            System.out.println(resource.toString());
        }
    }
}
