package ggadmin.controller.ums;

import ggadmin.common.api.CommonPage;
import ggadmin.common.api.CommonResult;
import ggadmin.model.ums.Menu;
import ggadmin.service.ums.MenuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Api(tags = "MenuController", consumes = "CRUD menu operators")
@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @ApiOperation("Lấy toàn bộ menu theo cấu trúc tree")
    @GetMapping("/treeList")
    @ResponseBody
    public ResponseEntity<?> getMenuTree() {
        return null;
    }

    @ApiOperation("Lấy về danh sách menu gốc")
    @GetMapping("/list/0")
    @ResponseBody
    public ResponseEntity<?> getRootMenu(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                         @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize) {
        Page<Menu> rootMenuPage = menuService.getRootMenuPage(pageNum, pageSize);
        CommonPage<Menu> menuCommonPage = CommonPage.restPage(rootMenuPage);
        return CommonResult.success(menuCommonPage);
    }

    @GetMapping("/list/{id}")
    public ResponseEntity<?> getSubMenuList(@PathVariable("id") Long rootMenuId,
                                            @RequestParam("pageNum") Integer pageNum,
                                            @RequestParam("pageSize") Integer pageSize) {
        Page<Menu> menuPage = menuService.getMenuPage(rootMenuId, pageNum, pageSize);
        CommonPage<Menu> menuCommonPage = CommonPage.restPage(menuPage);
        return CommonResult.success(menuCommonPage);
    }
}
