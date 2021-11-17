package ggadmin.dto.ums.mapper;

import ggadmin.dto.ums.RoleDTO;
import ggadmin.model.ums.Role;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface RoleMapper {

    RoleMapper INSTANCE = Mappers.getMapper(RoleMapper.class);
    RoleDTO toRoleDto(Role role);
}
