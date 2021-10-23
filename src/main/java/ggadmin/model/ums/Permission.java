package ggadmin.model.ums;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@Entity
@Table(name = "permission")
public class Permission implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "pid")
    private Long pid;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "value")
    private String value;

    @Column(name = "icon")
    private String icon;

    @Column(name = "type", nullable = false)
    private Long type;

    @Column(name = "uri")
    private String uri;

    @Column(name = "status", nullable = false)
    private Long status;

    @Column(name = "create_time", nullable = false)
    private Date createTime;

    @Column(name = "sort")
    private Long sort;

    @ManyToMany
    private List<Admin> admins;

    @ManyToMany
    private List<Role> roles;

}
