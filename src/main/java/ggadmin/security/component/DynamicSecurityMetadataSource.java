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
 * {@link #getAttributes(Object)} giúp lấy Resource theo yêu cầu của path truy cập hiện tại.
 * <p>
 * FilterInvocationSecurityMetadataSource là sub-interface của SecurityMetadataSource
 */
public class DynamicSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {

    private static Map<String, ConfigAttribute> configAttributeMap = null;

    @Autowired
    private DynamicSecurityService dynamicSecurityService;

    @PostConstruct
    public void loadDataSource() {
        configAttributeMap = dynamicSecurityService.loadDataSource();
    }

    public void clearDataSource() {
        configAttributeMap.clear();
        configAttributeMap = null;
    }

    @Override
    public Collection<ConfigAttribute> getAttributes(Object object) throws IllegalArgumentException {

        if (configAttributeMap == null) {
            this.loadDataSource();
        }

        // Lấy path hiện đang được request đến
        String url = ((FilterInvocation) object).getRequestUrl();
        String pathRequest = URLUtil.getPath(url);

        List<ConfigAttribute> configAttributes = new ArrayList<>();
        PathMatcher pathmatcher = new AntPathMatcher();
        Iterator<String> iterator = configAttributeMap.keySet().iterator(); // setKey là url của resource
        // Lấy resource được yêu cầu để truy cập vào path
        while (iterator.hasNext()) {
            String resourceUrl = iterator.next();
            // So sánh url resource và path đang được request đến, nếu trùng lấy resource liên quan đến path request
            if (pathmatcher.match(resourceUrl, pathRequest)) {
                configAttributes.add(configAttributeMap.get(resourceUrl));
            }
        }

        // The operation request permission is not set, and an empty collection is returned
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
