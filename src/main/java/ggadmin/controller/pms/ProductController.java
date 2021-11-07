package ggadmin.controller.pms;

import ggadmin.common.api.CommonResult;
import ggadmin.model.pms.Product;
import ggadmin.service.pms.ProductService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/product")
public class ProductController {

    private ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @PostMapping("/create")
    @ResponseBody
    @PreAuthorize("hasAuthority('pms:product:create')")
    public ResponseEntity<?> createProduct(@RequestBody Product product, BindingResult bindingResult) {
        var productAdded = productService.create(product);
        if (productAdded != null) {
            return CommonResult.success(productAdded);
        }
        return CommonResult.failed();
    }
}
