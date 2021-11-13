package ggadmin.controller.ums;

import ggadmin.common.api.CommonResult;
import ggadmin.model.ums.Resource;
import ggadmin.security.component.DynamicSecurityMetadataSource;
import ggadmin.service.ums.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;

    @Autowired
    private DynamicSecurityMetadataSource dynamicSecurityMetadataSource;

    @PostMapping("/create")
    @ResponseBody
    public ResponseEntity<?> create(@RequestBody Resource resource) {
        Boolean isCreated = resourceService.create(resource);
        dynamicSecurityMetadataSource.clearDataSource();
        if (isCreated) {
            return CommonResult.success(true);
        }
        return CommonResult.failed();
    }
}
