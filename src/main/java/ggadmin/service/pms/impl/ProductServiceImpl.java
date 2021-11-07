package ggadmin.service.pms.impl;

import ggadmin.model.pms.Product;
import ggadmin.repository.pms.ProductRepository;
import ggadmin.service.pms.ProductService;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService {

    private ProductRepository productRepository;

    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Override
    public Product create(Product product) {
        return productRepository.save(product);
    }
}
