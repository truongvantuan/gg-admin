package ggadmin.service.ums.impl;


import ggadmin.common.api.CommonResult;
import ggadmin.service.ums.MemberService;
import ggadmin.service.ums.RedisService;
import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class MemberServiceImpl implements MemberService {

    private final RedisService redisService;

    @Value("${redis.key.prefix.authCode}")
    private String REDIS_KEY_PREFIX_AUTH_CODE;

    @Value("${redis.key.expire.authCode}")
    private Long AUTH_CODE_EXPIRE_SECONDS;

    public MemberServiceImpl(RedisService redisService) {
        this.redisService = redisService;
    }

    @Override
    public ResponseEntity<?> generateAuthCode(String phoneNumber) {
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 6; i++) {
            sb.append(random.nextInt(10));
        }
        redisService.set(REDIS_KEY_PREFIX_AUTH_CODE + phoneNumber, sb.toString());
        redisService.expire(REDIS_KEY_PREFIX_AUTH_CODE + phoneNumber, AUTH_CODE_EXPIRE_SECONDS);
        return CommonResult.success(sb.toString(), "Get the verification code successfully");
    }

    @Override
    public ResponseEntity<?> verifyAuthCode(String phoneNumber, String authCode) {
        if (Strings.isEmpty(authCode)) {
            return CommonResult.failed("Please enter verification code");
        }
        String realAuthCode = redisService.get(REDIS_KEY_PREFIX_AUTH_CODE + phoneNumber);
        if (authCode.equals(realAuthCode)) {
            return CommonResult.success(null, "Code verified successfully");
        } else {
            return CommonResult.failed("Incorrect verification code");
        }
    }
}
