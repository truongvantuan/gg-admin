package ggadmin.security;

import ggadmin.dto.AdminUserDetails;
import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Permission;
import ggadmin.model.ums.Resource;
import ggadmin.security.component.DynamicSecurityService;
import ggadmin.security.config.SecurityConfig;
import ggadmin.service.ums.AdminService;
import ggadmin.service.ums.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class GGAdminSecurityConfig extends SecurityConfig {

    @Autowired
    private AdminService adminService;
    @Autowired
    private ResourceService resourceService;

    @Bean
    public UserDetailsService userDetailsService() {
        // TODO tối ưu lại theo Optional<>
        return username -> {
            Admin admin = adminService.getAdminByUsername(username).get();
            if (admin != null) {
                List<Resource> resources = adminService.getResources(admin.getId());
                return new AdminUserDetails(admin, resources);
            }
            throw new UsernameNotFoundException("Sai tên đăng nhập hoặc mật khẩu!");
        };
    }

    /**
     * Bean giúp lấy ra toàn bộ resource trong database, chuyển thành map có:
     * key là url (url đẫn đến resource)
     * value là ConfigAttribute - được wrap từ hai properties id:name của {@link Resource}
     * Ví dụ: 5:Product management
     *
     * @return Map<String, ConfigAttribute>
     */
    @Bean
    public DynamicSecurityService dynamicSecurityService() {
        return new DynamicSecurityService() {
            @Override
            public Map<String, ConfigAttribute> loadDataSource() {
                Map<String, ConfigAttribute> map = new ConcurrentHashMap<>();
                List<Resource> resourceList = resourceService.listAll(); // lấy tất cả Resource có trong database
                // Tạo ConfigAttribute từ thuộc tính của Resource
                for (Resource resource : resourceList) {
                    map.put(resource.getUrl(), new org.springframework.security.access.SecurityConfig(resource.getId() + ":" + resource.getName()));
                }
                return map;
            }
        };
    }

}
