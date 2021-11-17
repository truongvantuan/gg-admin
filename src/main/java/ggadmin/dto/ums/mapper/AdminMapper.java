package ggadmin.dto.ums.mapper;

import ggadmin.dto.ums.AdminDTO;
import ggadmin.model.ums.Admin;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface AdminMapper {

    AdminMapper INSTANCE = Mappers.getMapper(AdminMapper.class);

    AdminDTO toAdminDto(Admin admin);
}
