package ggadmin.service.ums.impl;

import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Role;
import ggadmin.repository.ums.AdminRepository;
import ggadmin.repository.ums.RoleRepository;
import ggadmin.service.ums.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private AdminRepository adminRepository;


    @Override
    public List<Role> getAllRole() {
        return roleRepository.findAll();
    }

    @Override
    public List<Role> getRolesByAdminId(Long adminId) {
        Admin admin = adminRepository.getById(adminId);
        return roleRepository.getAllByAdminsIs(admin);
    }

    @Override
    public Page<Role> getRolePage(Integer pageNum, Integer pageSize) {
        --pageNum;
        Pageable paging = PageRequest.of(pageNum, pageSize);
        return roleRepository.findAll(paging);
    }

    @Override
    public Page<Role> getRolePage(String keyword, Integer pageNum, Integer pageSize) {
        --pageNum;
        Pageable paging = PageRequest.of(pageNum, pageSize);
        return roleRepository.findAllByNameContainingIgnoreCase(keyword, paging);
    }

    @Override
    public boolean updateStatus(Long roleId, Integer roleStatus) {
        Role roleToUpdate = roleRepository.getById(roleId);
        roleToUpdate.setStatus(roleStatus);
        boolean isSuccess = true;
        try {
            roleRepository.save(roleToUpdate);
        } catch (Exception e) {
            isSuccess = false;
        }
        return isSuccess;
    }
}
