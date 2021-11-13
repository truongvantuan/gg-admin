package ggadmin.security.component;

import org.springframework.security.access.ConfigAttribute;

import java.util.Map;

public interface DynamicSecurityService {

    // TODO tìm hiểu ConfigAttribute
    Map<String, ConfigAttribute> loadDataSource();
}
