package ggadmin.controller.ums;

import ggadmin.common.api.CommonResult;
import ggadmin.dto.AdminDTO;
import ggadmin.dto.AdminLoginDTO;
import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Resource;
import ggadmin.service.ums.AdminService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(tags = "AdminController", consumes = "Admin controller, register, login")
@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    @Value("${jwt.tokenHeader}")
    private String tokenHeader;
    @Value("${jwt.tokenHead}")
    private String tokenHead;

    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }

    @ApiOperation(value = "Đăng ký tài khoản admin")
    @PostMapping("/register")
    @ResponseBody
    public ResponseEntity<?> register(@RequestBody
                                      @Valid AdminDTO adminDto, BindingResult bindingResult) {
        Admin admin = adminService.register(adminDto);
        if (admin == null) {
            return CommonResult.failed();
        }
        return CommonResult.success(admin, "Registry account successfully!");
    }

    @ApiOperation(value = "Đăng nhập tài khoản admin dùng username/password")
    @PostMapping("/login")
    @ResponseBody
    public ResponseEntity<?> login(@RequestBody AdminLoginDTO adminLoginDto, BindingResult bindingResult, HttpServletRequest request) {
        String token = adminService.login(adminLoginDto.getUsername(), adminLoginDto.getPassword());
        if (token == null) {
            return CommonResult.failed("Wrong username or password!");
        }
        adminService.saveLoginLog(adminService.getAdminByUsername(adminLoginDto.getUsername()).get().getId(), request);
        Map<String, Object> tokenMap = new HashMap<>();
        tokenMap.put("tokenHead", tokenHead);
        tokenMap.put("token", token);
        return CommonResult.success(tokenMap, "Login successfully!");
    }

    @GetMapping("/resource/{adminId}")
    public ResponseEntity<?> getPermissions(@PathVariable Long adminId) {
        List<Resource> resourceList = adminService.getResources(adminId);
        return CommonResult.success(resourceList);
    }
}
