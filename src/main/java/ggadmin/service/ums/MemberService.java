package ggadmin.service.ums;

import org.springframework.http.ResponseEntity;

public interface MemberService {

    ResponseEntity<?> generateAuthCode(String phoneNumber);

    ResponseEntity<?> verifyAuthCode(String phoneNumber, String authCode);
}
