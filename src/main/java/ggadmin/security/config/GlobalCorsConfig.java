package ggadmin.security.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

/**
 * Global cross-domain configuration
 */
@Configuration
public class GlobalCorsConfig {

    // Filters cho phép các yêu cầu cross-domain
    @Bean
    public CorsFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        // cho phép tất cả các domain thực hiện cuộc gọi cross-domain
        // config.addAllowedOrigin("*");
        config.addAllowedOriginPattern("*");
        // Cho phép gửi cookie qua
        config.setAllowCredentials(true);
        // Cho phép tất cả các thuộc tính Header
        config.addAllowedHeader("*");
        // Cho phép tất cả cá method
        config.addAllowedMethod("*");
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return new CorsFilter(source);
    }
}
