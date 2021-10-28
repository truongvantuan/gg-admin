package ggadmin;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;

@SpringBootTest
class ggAdminApplicationTests {

    @Test
    void contextLoads() {
        Date date = new Date();
        var time = date.getTime();
        System.out.println(time);
    }

}
