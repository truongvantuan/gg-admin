package ggadmin.repository.ums;

import ggadmin.dto.PermissionDTO;
import ggadmin.model.ums.Admin;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class AdminRepositoryTest {

    @Autowired
    AdminRepository adminRepository;

    @Test
    void selectAdminTest() {
        List<Admin> adminList = adminRepository.selectAllAdmin();
        for (Admin ad : adminList) {
            System.out.println(ad.toString());
        }
    }
}
