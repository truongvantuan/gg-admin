package ggadmin.service.pms.impl;

import ggadmin.model.pms.Brand;
import ggadmin.repository.pms.BrandRepository;
import ggadmin.service.pms.BrandService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class BrandServiceImpl implements BrandService {

    private BrandRepository brandRepository;

    public BrandServiceImpl(BrandRepository brandRepository) {
        this.brandRepository = brandRepository;
    }

    @Override
    public Page<Brand> getBrandPage(Integer pageNum, Integer pageSize) {
        pageNum--;
        Pageable paging = PageRequest.of(pageNum, pageSize);
        return brandRepository.findAll(paging);
    }
}
