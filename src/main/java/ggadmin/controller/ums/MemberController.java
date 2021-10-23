package ggadmin.controller.ums;

import ggadmin.service.ums.MemberService;
import io.swagger.annotations.Api;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Api(tags = "UserController", consumes = "User login")
@Controller
@RequestMapping("/sso")
public class MemberController {

    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping(value = "/getAuthCode")
    public ResponseEntity<?> getAuthCode(@RequestParam String phoneNumber) {
        return memberService.generateAuthCode(phoneNumber);
    }

    @PostMapping(value = "/verifyAuthCode")
    public ResponseEntity<?> updatePassword(@RequestParam String phoneNumber, @RequestParam String authCode) {
        return memberService.verifyAuthCode(phoneNumber, authCode);
    }
}
