package ggadmin.dto.ums.mapper;

import org.mapstruct.Mapping;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Annotation giúp ánh xạ DTO (gửi từ client) sang Entity
 * Cấu hình các ánh xạ chung, giống nhau, có giá trị mặc định cho các Entity
 */
@Retention(RetentionPolicy.CLASS)
@Mapping(target = "id", ignore = true) // Bỏ qua thuộc tính id gửi từ client
@Mapping(target = "createTime", expression = "java(new java.util.Date())") // Tạo mốc thời điểm hiện tại cho thuộc tính createTime phía Role entity
@Mapping(target = "sort", defaultValue = "0") // Mặc định giá trị thuộc tính sort là 0
public @interface ToRoleEntity {
}
