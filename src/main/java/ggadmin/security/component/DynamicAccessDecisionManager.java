package ggadmin.security.component;

import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;
import java.util.Iterator;

/**
 * Trình quản lý quyết định kiểm soát truy cập (access control),
 * được sử dụng để đánh giá liệu người dùng (request) có quyền truy cập đến resource hay không.
 */
public class DynamicAccessDecisionManager implements AccessDecisionManager {

    /**
     * Decide được truyền vào các thông tin liên quan cần thiết để đưa ra quyết định phân quyền.
     *
     * @param authentication
     * @param object           secure object ở đây là method trong controller
     * @param configAttributes configAttribute của resource mà request đang cần truy cập
     * @throws AccessDeniedException
     * @throws InsufficientAuthenticationException
     */
    @Override
    public void decide(Authentication authentication, Object object, Collection<ConfigAttribute> configAttributes) throws AccessDeniedException, InsufficientAuthenticationException {

        // TODO xem lại check này
        // Resource chưa được cấu hình, cho phép truy cập không cần phân quyền
        if (configAttributes.isEmpty()) {
            return;
        }

        Iterator<ConfigAttribute> iterator = configAttributes.iterator();
        while (iterator.hasNext()) {
            ConfigAttribute configAttribute = iterator.next();
            // So sánh resources cần truy cập với resources người dùng sở hữu, hợp lệ cho phép truy cập
            String needAuthority = configAttribute.getAttribute();
            for (GrantedAuthority grantedAuthority : authentication.getAuthorities()) {
                if (needAuthority.trim().equals(grantedAuthority.getAuthority())) {
                    return;
                }
            }
        }
        throw new AccessDeniedException("Bạn không có quyền truy cập!");
    }

    @Override
    public boolean supports(ConfigAttribute attribute) {
        return true;
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return true;
    }
}
