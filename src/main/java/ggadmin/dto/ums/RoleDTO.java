package ggadmin.dto.ums;

import lombok.Data;

import java.util.Date;

@Data
public class RoleDTO {

    private Long id;
    private String name;
    private String description;
    private String adminCount;
    private Date createTime;
    private Integer status;
    private Integer sort;
}
