package ggadmin;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class GGAdminApplication {

    public static void main(String[] args) {
//        ApplicationContext context =
        SpringApplication.run(GGAdminApplication.class, args);
  /*      ResourceRepository resourceRepository = context.getBean("resourceRepository", ResourceRepository.class);
        List<Resource> resourceList = resourceRepository.getResourcesByAdminId(3L);
        for (Resource resource : resourceList) {
            System.out.println(resource.toString());
        }*/
    }
}
