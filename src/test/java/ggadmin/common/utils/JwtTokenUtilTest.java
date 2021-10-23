package ggadmin.common.utils;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

class JwtTokenUtilTest {

    private static JwtTokenUtil jwtTokenUtil = new JwtTokenUtil();
    private static Map<String, Object> claims = new HashMap<>();

    @BeforeAll
    public static void setUp() {
        jwtTokenUtil.setSecret("h68H6auu");
        jwtTokenUtil.setExpiration(604800L);
        claims.put("sub", "truongtuan");
        claims.put("created", new Date());
    }

    @Test
    void generateTokenFromClaimsTest() {
        String token = jwtTokenUtil.generateToken(claims);
        assertNotNull(token);
        assertTrue(isTokenFormat(token));
        System.out.println(token);
       /*String token1 = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0cnVvbmd0dWFuIiwiY3JlYXRlZCI6MTYzNDcwMjc5MDc0NiwiZXhwIjoxNjM1MzA3NTkxfQ.qaqXOXYtlTxOdrxuiG1X6mM9DlOTJeZ4Sp4gy0Vg9FA";
        var strParts = token1.split("[.]");
        System.out.println(strParts);
        for (String str : strParts) {
            System.out.println(str);
        }*/
    }

    @Test
    void generateTokenFromUserDetail() {
    }

    @Test
    void generateTokenFromUsername_thenGetThisUsernameFromToken() {
        String token = jwtTokenUtil.generateToken(claims);
        String username = jwtTokenUtil.getUserFromToken(token);
        System.out.println(username);
        assertThat(username).isEqualTo("truongtuan");
    }

    @Test
    void validateTokenTest() {
    }

    @Test
    void isTokeExpired() {
    }

    @Test
    void getExpiredDateFromToken() {
    }

    public static boolean isTokenFormat(String token) {
        String[] strParts = token.split("[.]");
        return strParts.length == 3;
    }
}
