package ggadmin.controller.ums;

import ggadmin.common.api.CommonPage;
import ggadmin.common.api.CommonResult;
import ggadmin.dto.ums.RoleDTO;
import ggadmin.dto.ums.mapper.RoleMapper;
import ggadmin.model.ums.Menu;
import ggadmin.model.ums.Role;
import ggadmin.service.ums.RoleService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

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
        Page<RoleDTO> roleDTOPage = rolePage.map(RoleMapper.INSTANCE::toRoleDto);
        CommonPage<RoleDTO> roleDTOCommonPage = CommonPage.restPage(roleDTOPage);
        return CommonResult.success(roleDTOCommonPage);
    }

    @ApiOperation("Cập nhật trạng thái kích hoạt của Role")
    @PostMapping("/updateStatus/{id}")
    @ResponseBody
    public ResponseEntity<?> updateStatus(@PathVariable("id") Long roleId,
                                          @RequestParam("status") Integer status) {
        return roleService.updateStatus(roleId, status) ? CommonResult.success(null) : CommonResult.failed();
    }

    @ApiOperation("Tạo mới Role")
    @PostMapping("/create")
    @ResponseBody
    public ResponseEntity<?> createRole(@RequestBody RoleDTO roleDTO, BindingResult bindingResult) {
        return roleService.create(roleDTO) ? CommonResult.success(null) : CommonResult.failed();
    }

    @ApiOperation("Cập nhật thông tin Role")
    @PostMapping("/update/{id}")
    @ResponseBody
    public ResponseEntity<?> updateRole(@PathVariable("id") Long roleId,
                                        @RequestBody RoleDTO roleDTO) {
        return roleService.updateRole(roleId, roleDTO) ? CommonResult.success(null) : CommonResult.failed();
    }

    @ApiOperation("Xóa Role")
    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<?> delete(@RequestParam("ids") Long roleId) {
        return roleService.delete(roleId) ? CommonResult.success(null) : CommonResult.failed();
    }

    @ApiOperation("Lấy danh sách tất cả menus mà Role sở hữu")
    @GetMapping("/listMenu/{id}")
    @ResponseBody
    public ResponseEntity<?> getMenus(@PathVariable("id") Long roleId) {
        List<Menu> menuList = roleService.getMenus(roleId);
        return CommonResult.success(menuList);
    }

}
