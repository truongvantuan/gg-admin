package ggadmin.dto.ums.mapper;

import org.mapstruct.Mapping;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.CLASS)
@Mapping(target = "id", ignore = true)
@Mapping(target = "roles", ignore = true)
@Mapping(target = "createTime", expression = "java(new java.util.Date())")
@Mapping(target = "icon", defaultValue = "null")
public @interface ToAdminEntity {
}
