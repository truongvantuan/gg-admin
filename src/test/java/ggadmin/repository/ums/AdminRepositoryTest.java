package ggadmin.repository.ums;

import ggadmin.dto.PermissionDTO;
import ggadmin.model.ums.Permission;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class AdminRepositoryTest {

    @Autowired
    PermissionDAO permissionDAO;
    @Autowired
    AdminRepository adminRepository;

    @Test
    void test() {
        List<PermissionDTO> permissions = adminRepository.getPermissionsByAdminId(1L);
        assertThat(permissions).isNotEmpty();
        for (PermissionDTO p : permissions) {
            System.out.println(p.toString());
        }
    }
}
