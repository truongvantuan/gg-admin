package ggadmin.controller.ums;

import ggadmin.common.api.CommonPage;
import ggadmin.common.api.CommonResult;
import ggadmin.dto.ums.AdminDTO;
import ggadmin.dto.ums.AdminInfoDTO;
import ggadmin.dto.ums.AdminLoginDTO;
import ggadmin.dto.ums.RoleDTO;
import ggadmin.dto.ums.mapper.AdminMapper;
import ggadmin.dto.ums.mapper.RoleMapper;
import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Resource;
import ggadmin.model.ums.Role;
import ggadmin.service.ums.AdminService;
import ggadmin.service.ums.RoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Api(tags = "AdminController", consumes = "Admin controller, register, login")
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Value("${jwt.tokenHeader}")
    private String tokenHeader;
    @Value("${jwt.tokenHead}")
    private String tokenHead;

    private final AdminService adminService;
    private final RoleService roleService;


    public AdminController(AdminService adminService, RoleService roleService) {
        this.adminService = adminService;
        this.roleService = roleService;
    }

    @ApiOperation(value = "Đăng ký tài khoản admin")
    @PostMapping("/register")
    @ResponseBody
    public ResponseEntity<?> register(@RequestBody
                                      @Valid Admin admin, BindingResult bindingResult) {
        Admin adminAdded = adminService.register(admin);
        if (adminAdded == null) {
            return CommonResult.failed();
        }
        return CommonResult.success(adminAdded, "Registry account successfully!");
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

    @ApiOperation("Đăng xuất")
    @PostMapping("/logout")
    @ResponseBody
    public ResponseEntity<?> logout() {
        return CommonResult.success(null);
    }

    @ApiOperation("Lấy về tất cả các resources mà Admin sở hữu")
    @GetMapping("/resource/{adminId}")
    @ResponseBody
    public ResponseEntity<?> getResources(@PathVariable Long adminId) {
        List<Resource> resourceList = adminService.getResources(adminId);
        return CommonResult.success(resourceList);
    }

    @ApiOperation("Lấy tất cả thông tin Roles, Menus sở hữu bởi Admin")
    @GetMapping("/info")
    @ResponseBody
    public ResponseEntity<?> getAdminInfo(Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Chưa đăng nhập hoặc token đã hết hạn!");
        }
        AdminInfoDTO adminInfo = adminService.getAdminInfo(principal);
        return CommonResult.success(adminInfo);
    }

    @ApiOperation("Lấy tất cả các Admin đang có")
    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<?> getAdminList(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                          @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                          @RequestParam(value = "keyword", required = false) String keyword) {
        Page<Admin> adminPage;
        if (keyword == null) {
            adminPage = adminService.getAdminPage(pageNum, pageSize);
        } else {
            adminPage = adminService.getAdminPage(pageNum, pageSize, keyword);
        }

        Page<AdminDTO> adminDtoPage = adminPage.map(AdminMapper.INSTANCE::toAdminDto);

        CommonPage<AdminDTO> adminDTOCommonPage = CommonPage.restPage(adminDtoPage);
        return CommonResult.success(adminDTOCommonPage);
        /*CommonPage<Admin> adminCommonPage = CommonPage.restPage(adminPage);
        return CommonResult.success(adminCommonPage);*/
    }

    @ApiOperation("Lấy role sở hữu bởi Admin theo adminId")
    @GetMapping("/role/{id}")
    public ResponseEntity<?> getRoleByAdmin(@PathVariable("id") Long adminId) {
        List<Role> roleList = roleService.getRolesByAdminId(adminId);
        List<RoleDTO> roleDtoList = roleList.stream()
                .map(RoleMapper.INSTANCE::toRoleDto)
                .collect(Collectors.toList());
        return CommonResult.success(roleDtoList);
    }

    @PostMapping("/delete/{id}")
    @ResponseBody
    public ResponseEntity<?> deleteAdmin(@PathVariable("id") Long adminId) {
        adminService.delete(adminId);
        return CommonResult.success(null, "Delete successfully!");
    }

    @PostMapping("role/update")
    @ResponseBody
    public ResponseEntity<?> allocRole(@RequestParam("adminId") Long adminId,
                                       @RequestParam("roleIds") List<Long> rolesIds) {
        boolean success = adminService.updateRole(adminId, rolesIds);
        if (success) {
            return CommonResult.success(null);
        }
        return CommonResult.failed();
    }

    @PostMapping("/update/{id}")
    public ResponseEntity<?> update(@PathVariable("id") Long adminId, @RequestBody AdminDTO adminDTO) {
        boolean isSuccess = adminService.update(adminId, adminDTO);
        if (!isSuccess) {
            return CommonResult.failed("Update failed!");
        }
        return CommonResult.success("Update successfully!");
    }

    @PostMapping("/updateStatus/{id}")
    public ResponseEntity<?> updateAdminStatus(@PathVariable(value = "id") Long adminId,
                                               @RequestParam(value = "status") Integer status) {
        if (adminService.updateStatus(adminId, status)) {
            return CommonResult.success(null);
        }
        return CommonResult.failed();
    }
}
