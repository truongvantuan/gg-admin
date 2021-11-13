package ggadmin.service.ums;

import ggadmin.model.ums.Resource;

import java.util.List;

public interface ResourceService {

    List<Resource> listAll();
    Boolean create(Resource resource);
}
