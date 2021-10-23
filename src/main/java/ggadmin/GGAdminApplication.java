package ggadmin;

import ggadmin.model.ums.Permission;
import ggadmin.repository.ums.AdminRepository;
import ggadmin.repository.ums.PermissionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@SpringBootApplication
public class GGAdminApplication {

    public static void main(String[] args) {
        ApplicationContext applicationContext = SpringApplication.run(GGAdminApplication.class, args);
        List<String> beans = Arrays.asList(applicationContext.getBeanDefinitionNames());
        Collections.sort(beans);
        for (Object b : beans) {
            System.out.println(b.toString());
        }
    }
}
