package ggadmin;

import ggadmin.dto.PermissionDTO;
import ggadmin.repository.ums.AdminRepository;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Set;

@SpringBootApplication
public class GGAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(GGAdminApplication.class, args);
/*        ApplicationContext applicationContext = SpringApplication.run(GGAdminApplication.class, args);
        List<String> beans = Arrays.asList(applicationContext.getBeanDefinitionNames());
        Collections.sort(beans);
        for (Object b : beans) {
            System.out.println(b.toString());
        }
        AdminRepository repository = applicationContext.getBean(AdminRepository.class);

        List<PermissionDTO> permissions = repository.getPermissionsByAdminId(1L);
        for (PermissionDTO p : permissions) {
            System.out.println(p.toString());
        }*/
    }
}
