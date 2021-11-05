package ggadmin.service.pms;

import ggadmin.model.pms.Brand;
import org.springframework.data.domain.Page;

public interface BrandService {

    Page<Brand> getBrandPage(Integer pageNum, Integer pageSize);
}
