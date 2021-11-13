package ggadmin.security.component;

import ggadmin.security.config.IgnoreUrlsConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.security.access.SecurityMetadataSource;
import org.springframework.security.access.intercept.AbstractSecurityInterceptor;
import org.springframework.security.access.intercept.InterceptorStatusToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.FilterInvocation;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Collection;

/**
 * Filter dùng cho dynamic permission controller.
 * Cho tất cả OPTIONS request đi qua.
 * Cho tất cả các request tới các path đã được cấu hình tại secure.ignored.urls (mapping vào IgnoreUrlsConfig) đi qua.
 * FilterSecurityInterceptor là sub-interface của AbstractSecurityInterceptor
 */
public class DynamicSecurityFilter extends AbstractSecurityInterceptor implements Filter {

    @Autowired
    private DynamicSecurityMetadataSource dynamicSecurityMetadataSource;

    @Autowired
    private IgnoreUrlsConfig ignoreUrlsConfig;

    // Cài đặt AccessDecisionManager cho FilterSecurityInterceptor sử dụng
    @Autowired
    public void setMyAccessDecisionManager(DynamicAccessDecisionManager dynamicAccessDecisionManager) {
        super.setAccessDecisionManager(dynamicAccessDecisionManager);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest,
                         ServletResponse servletResponse,
                         FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        FilterInvocation fi = new FilterInvocation(servletRequest, servletResponse, filterChain);

        // OPTIONS request được phép đi qua filter
        if (request.getMethod().equals(HttpMethod.OPTIONS.toString())) {
            fi.getChain().doFilter(fi.getRequest(), fi.getResponse());
            return;
        }

        PathMatcher pathMatcher = new AntPathMatcher();
        // Các request nằm trong whitelist path đã cấu hình sẵn, cho phép đi qua filter
        for (String path : ignoreUrlsConfig.getUrls()) {
            if (pathMatcher.match(path, request.getRequestURI())) {
                fi.getChain().doFilter(fi.getRequest(), fi.getResponse());
                return;
            }
        }

        /**
         * Tất cả các hoạt động phân quyền còn lại được diễn ra tại đây, hàm beforeInvocation() gọi tới
         * hàm {@link DynamicAccessDecisionManager#decide(Authentication, Object, Collection)} thực hiện phân quyền.
         * ConfigAttribute truyền vào decide() được cung cấp bởi {@link DynamicSecurityMetadataSource#getAttributes(Object)}
         * thứ cần để quyết định quyền truy cập tới Resources
         */
        InterceptorStatusToken token = super.beforeInvocation(fi);
        try {
            fi.getChain().doFilter(fi.getRequest(), fi.getResponse());
        } finally {
            super.afterInvocation(token, null);
        }

    }

    @Override
    public void destroy() {
    }

    @Override
    public Class<?> getSecureObjectClass() {
        return FilterInvocation.class;
    }

    @Override
    public SecurityMetadataSource obtainSecurityMetadataSource() {
        return dynamicSecurityMetadataSource;
    }
}
