package ggadmin.common.utils;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class JwtTokenUtilTest {

    private static final String TOKEN_SECRET = "h68H6auu";
    private static final Long TOKEN_EXPIRATION = 604800L; // 60*60*24*7
    //    private static final Long TOKEN_CREATED_DATE = 1635414084119L;
    private static JwtTokenUtil jwtTokenUtil = new JwtTokenUtil();
    private static Map<String, Object> claims = new HashMap<>();

    @Mock
    private UserDetails userDetails;

    @BeforeAll
    public static void setUp() {
        jwtTokenUtil.setSecret(TOKEN_SECRET);
        jwtTokenUtil.setExpiration(TOKEN_EXPIRATION);
        Date createdDate = new Date();
        claims.put("sub", "truongtuan");
        claims.put("created", createdDate);
    }

    @Test
    void validateTokenTest() {
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
    void generateTokenFromUserDetailTest() {
        when(userDetails.getUsername()).thenReturn("truongtuan");
        String token = jwtTokenUtil.generateToken(userDetails);
        System.out.println(token);
        assertThat(isTokenFormat(token)).isTrue();
    }

    @Test
    void generateTokenFromUsername_thenGetThisUsernameFromToken() {
        String token = jwtTokenUtil.generateToken(claims);
        String username = jwtTokenUtil.getUserFromToken(token);
        System.out.println(username);
        assertThat(username).isEqualTo("truongtuan");
    }

    @Test
    void isTokeExpired() {
    }

    @Test
    void getExpiredDateFromToken() {
    }

    // Kiểm tra chuỗi token có 3 phần chia tách bởi dấu [.] xxx.yyy.zzz
    private boolean isTokenFormat(String token) {
        String[] strParts = token.split("[.]");
        return strParts.length == 3;
    }
}
