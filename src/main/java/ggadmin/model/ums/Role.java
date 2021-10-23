package ggadmin.model.ums;

import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Set;

@Data
@Entity
@Table(name = "role")
public class Role implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @NotNull
    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description")
    private String description;

    @NotNull
    @Column(name = "admin_count")
    private Integer adminCount;

    @NotNull
    @Column(name = "create_time")
    private Date createTime;

    @NotNull
    @Column(name = "status")
    private Integer status;

    @Column(name = "sort")
    private Integer sort;

    @ManyToMany(mappedBy = "roles")
    private Set<Admin> admins;

    @ManyToMany
    @JoinTable(name = "role_permission_relation",
            joinColumns = @JoinColumn(name ="role_id"),
            inverseJoinColumns = @JoinColumn(name = "permission_id")
    )
    private Set<Permission> permissions;

}
