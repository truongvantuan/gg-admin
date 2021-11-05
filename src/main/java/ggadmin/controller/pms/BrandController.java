package ggadmin.controller.pms;

import ggadmin.common.api.CommonPage;
import ggadmin.common.api.CommonResult;
import ggadmin.model.pms.Brand;
import ggadmin.service.pms.BrandService;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/brand")
public class BrandController {

    private BrandService brandService;

    public BrandController(BrandService brandService) {
        this.brandService = brandService;
    }

    @GetMapping("/list")
    public ResponseEntity<?> getBrands(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                       @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize) {
        Page<Brand> brandPage = brandService.getBrandPage(pageNum, pageSize);
        CommonPage<Brand> brandCommonPage = CommonPage.restPage(brandPage);
        return CommonResult.success(brandCommonPage, "Danh sách brand của bạn sẵn sàng!");
    }
}
