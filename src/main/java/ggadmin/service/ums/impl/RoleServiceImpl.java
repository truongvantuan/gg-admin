package ggadmin.service.ums.impl;

import ggadmin.dto.ums.RoleDTO;
import ggadmin.dto.ums.mapper.RoleMapper;
import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Menu;
import ggadmin.model.ums.Role;
import ggadmin.repository.ums.AdminRepository;
import ggadmin.repository.ums.MenuRepository;
import ggadmin.repository.ums.RoleRepository;
import ggadmin.service.ums.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private AdminRepository adminRepository;
    @Autowired
    private MenuRepository menuRepository;


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

    @Override
    public boolean create(RoleDTO roleDTO) {
        Role roleToAdd = RoleMapper.INSTANCE.toRoleEntity(roleDTO);
        boolean isSuccess = true;
        try {
            roleRepository.save(roleToAdd);
        } catch (RuntimeException e) {
            isSuccess = false;
        }
        return isSuccess;
    }

    @Override
    public boolean updateRole(Long roleId, RoleDTO roleDTO) {
        Role roleToUpdate = roleRepository.getById(roleId);
        roleToUpdate.setName(roleDTO.getName());
        roleToUpdate.setDescription(roleDTO.getDescription());
        roleToUpdate.setStatus(roleDTO.getStatus());
        boolean isUpdated = true;
        try {
            roleRepository.save(roleToUpdate);
        } catch (RuntimeException e) {
            isUpdated = false;
        }
        return isUpdated;
    }

    @Override
    public boolean delete(Long roleId) {
        boolean isDeleted = true;
        try {
            roleRepository.deleteById(roleId);
        } catch (RuntimeException e) {
            isDeleted = false;
        }
        return isDeleted;
    }

    @Override
    public List<Menu> getMenus(Long roleId) {
        Role role = roleRepository.findById(roleId).get();
        List<Role> roleList = Collections.singletonList(role);
        return menuRepository.getAllByRolesIn(roleList);
    }
}
