package ggadmin.security.config;

import ggadmin.security.component.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.configurers.ExpressionUrlAuthorizationConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired(required = false)
    private DynamicSecurityService dynamicSecurityService;

    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        ExpressionUrlAuthorizationConfigurer<HttpSecurity>.ExpressionInterceptUrlRegistry registry = httpSecurity
                .authorizeRequests();

        // Cho phép truy cập đến Resource đã được cấu hình không áp dụng secure (secure.ignored)
        for (String url : ignoreUrlsConfig().getUrls()) {
            registry.antMatchers(url).permitAll();
        }

        // OPTIONS requests cho phép đi qua filter
        registry.antMatchers(HttpMethod.OPTIONS)
                .permitAll();

        // Xác thực, phân quyền các request còn lại
        registry.and()
                .authorizeRequests()
                .anyRequest()
                .authenticated()
                // Turn off cross-site request protection and do not use session
                .and()
                .csrf()
                .disable()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                // Custom permission denied processing class
                .and()
                .exceptionHandling()
                .accessDeniedHandler(restfulAccessDeniedHandler())
                .authenticationEntryPoint(restAuthenticationEntryPoint())
                // Custom permission interceptor JWT filter
                .and()
                .addFilterBefore(jwtAuthenticationTokenFilter(), UsernamePasswordAuthenticationFilter.class);
        // Add dynamic permission verification filter when there is dynamic permission configuration
        if (dynamicSecurityService != null) {
            registry.and().addFilterBefore(dynamicSecurityFilter(), FilterSecurityInterceptor.class);
        }
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService())
                .passwordEncoder(passwordEncoder());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public JwtAuthenticationTokenFilter jwtAuthenticationTokenFilter() {
        return new JwtAuthenticationTokenFilter();
    }

    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Bean
    public IgnoreUrlsConfig ignoreUrlsConfig() {
        return new IgnoreUrlsConfig();
    }

    // TODO tìm hiểu annotation @ConditionalOnBean
    @ConditionalOnBean(name = "dynamicSecurityService")
    @Bean
    public DynamicSecurityMetadataSource dynamicSecurityMetadataSource() {
        return new DynamicSecurityMetadataSource();
    }

    @ConditionalOnBean(name = "dynamicSecurityService")
    @Bean
    public DynamicAccessDecisionManager dynamicAccessDecisionManager() {
        return new DynamicAccessDecisionManager();
    }

    @ConditionalOnBean(name = "dynamicSecurityService")
    @Bean
    public DynamicSecurityFilter dynamicSecurityFilter() {
        return new DynamicSecurityFilter();
    }

    @Bean
    public RestfulAccessDeniedHandler restfulAccessDeniedHandler() {
        return new RestfulAccessDeniedHandler();
    }

    @Bean
    public RestAuthenticationEntryPoint restAuthenticationEntryPoint() {
        return new RestAuthenticationEntryPoint();
    }

}

//    @Override
//    protected void configure(HttpSecurity httpSecurity) throws Exception {
//        httpSecurity.csrf() // Since we are using JWT, we don’t need csrf here
//                .disable()
//                .sessionManagement() // Based on token, so no session is needed
//                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
//                .and()
//                .authorizeRequests()
//                .antMatchers(
//                        HttpMethod.GET, // Allow unauthorized access to website static resources
//                        "/",
//                        "/*.html",
//                        "/favicon.ico",
//                        "/**/*.html",
//                        "/**/*.css",
//                        "/**/*.js",
//                        "/swagger-resources/**",
//                        "/v2/api-docs/**"
//                )
//                .permitAll()
//                .antMatchers("/admin/login", "/admin/register") // Allow anonymous access for login registration
//                .permitAll()
//                // TODO - xem thêm về cross-domain
//                .antMatchers(HttpMethod.OPTIONS) // Cross-domain requests will first make an options request
//                .permitAll()
//                .antMatchers("/**") // Cho phép truy cập cất cả resources để testing
//                .permitAll()
//                .anyRequest() // All requests except the above require authentication
//                .authenticated();
//        // Disable caching
//        httpSecurity.headers().cacheControl();
//        // Add JWT filter
//        httpSecurity.addFilterBefore(jwtAuthenticationTokenFilter(), UsernamePasswordAuthenticationFilter.class);
//        // Add custom unauthorized and unlogged result return
//        httpSecurity.exceptionHandling()
//                .accessDeniedHandler(restfulAccessDeniedHandler)
//                .authenticationEntryPoint(restAuthenticationEntryPoint);
//    }
