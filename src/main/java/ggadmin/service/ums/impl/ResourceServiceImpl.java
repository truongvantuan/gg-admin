package ggadmin.service.ums.impl;

import ggadmin.model.ums.Resource;
import ggadmin.repository.ums.ResourceRepository;
import ggadmin.service.ums.ResourceService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ResourceServiceImpl implements ResourceService {

    private ResourceRepository resourceRepository;

    public ResourceServiceImpl(ResourceRepository resourceRepository) {
        this.resourceRepository = resourceRepository;
    }

    @Override
    public List<Resource> listAll() {
        return resourceRepository.findAll();
    }

    @Override
    public Boolean create(Resource resource) {
        Boolean isCreated;
        try {
            resourceRepository.save(resource);
            isCreated = true;
        } catch (RuntimeException e) {
            isCreated = false;
        }
        return isCreated;
    }
}
