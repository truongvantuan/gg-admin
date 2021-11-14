package ggadmin.security.component;

import cn.hutool.core.util.URLUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;

import javax.annotation.PostConstruct;
import java.util.*;

/**
 * Biết được Principle từ Authentication đã xác thực thành công, được cung cấp từ SecurityContextHolder,
 * {@link #getAttributes(Object)} giúp lấy configAttribute thuộc Resource theo yêu cầu của path truy cập hiện tại.
 * <p>
 * FilterInvocationSecurityMetadataSource là sub-interface của SecurityMetadataSource
 */
public class DynamicSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {

    private static Map<String, ConfigAttribute> allConfigAttributeMap = null;

    @Autowired
    private DynamicSecurityService dynamicSecurityService;

    @PostConstruct
    public void loadDataSource() {
        allConfigAttributeMap = dynamicSecurityService.loadDataSource();
    }

    public void clearDataSource() {
        allConfigAttributeMap.clear();
        allConfigAttributeMap = null;
    }

    @Override
    public Collection<ConfigAttribute> getAttributes(Object object) throws IllegalArgumentException {

        if (allConfigAttributeMap == null) {
            this.loadDataSource();
        }

        // Lấy path hiện đang được request đến
        String url = ((FilterInvocation) object).getRequestUrl();
        String requestPath = URLUtil.getPath(url);

        List<ConfigAttribute> configAttributes = new ArrayList<>();
        PathMatcher pathmatcher = new AntPathMatcher();
        Iterator<String> iterator = allConfigAttributeMap.keySet().iterator(); // setKey là url của resource
        // Lấy resource mà request yêu cầu
        while (iterator.hasNext()) {
            String resourcePath = iterator.next();
            // So sánh url resource và path đang được request đến, đúng lấy resource mà request yêu cầu
            if (pathmatcher.match(resourcePath, requestPath)) {
                configAttributes.add(allConfigAttributeMap.get(resourcePath));
            }
        }

        return configAttributes;
    }

    @Override
    public Collection<ConfigAttribute> getAllConfigAttributes() {
        return null;
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return true;
    }
}
