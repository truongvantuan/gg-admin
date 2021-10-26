package ggadmin.repository.ums;

import ggadmin.model.ums.Permission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.List;

@Repository
@Transactional
public class PermissionDaoImpl implements PermissionDAO {

    @Autowired
    private EntityManager entityManager;

    @Override
    public List<Permission> getPermissionsByAdminID(Long adminId) {
        List<Permission> permissions =
                entityManager.createNamedQuery("getPermissionsByAdminId", Permission.class)
                        .setParameter(1, adminId)
                        .getResultList();
        return permissions;
    }
}
