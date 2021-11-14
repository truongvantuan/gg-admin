package ggadmin.repository.ums;

import ggadmin.model.ums.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class ResourceRepositoryTest {

    @Autowired
    ResourceRepository resourceRepository;

    @Test
    void getResourceByAdminId() {
        List<Resource> resourceList = resourceRepository.getResourcesByAdminId(3L);
        for (Resource resource : resourceList) {
            System.out.println(resource.toString());
            System.out.println(resourceList.size());
        }
    }
}
