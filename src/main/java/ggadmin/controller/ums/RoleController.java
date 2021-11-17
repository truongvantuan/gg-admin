package ggadmin.controller.ums;

import ggadmin.common.api.CommonPage;
import ggadmin.common.api.CommonResult;
import ggadmin.model.ums.Role;
import ggadmin.service.ums.RoleService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @ApiOperation("Lấy tất cả Roles có trong database")
    @GetMapping("/listAll")
    @ResponseBody
    public ResponseEntity<?> getAllRole() {
        List<Role> roleList = roleService.getAllRole();
        return CommonResult.success(roleList);
    }

    @ApiOperation("Lấy về phân trang của Roles")
    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<?> getRolePage(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                         @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                         @RequestParam(value = "keyword", required = false) String keyword) {
        Page<Role> rolePage;
        if (keyword == null) {
            rolePage = roleService.getRolePage(pageNum, pageSize);
        } else {
            rolePage = roleService.getRolePage(keyword, pageNum, pageSize);
        }
        CommonPage<Role> roleCommonPage = CommonPage.restPage(rolePage);
        return CommonResult.success(roleCommonPage);
    }

}
