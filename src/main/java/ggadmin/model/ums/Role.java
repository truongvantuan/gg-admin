package ggadmin.model.ums;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "role", schema = "ums")
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
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_time")
    private Date createTime;

    @NotNull
    @Column(name = "status")
    private Integer status;

    @Column(name = "sort")
    private Integer sort;

    @ManyToMany(mappedBy = "roles")
    @JsonIgnore
    private Set<Admin> admins;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "role_permission_relation",
            schema = "ums",
            joinColumns = @JoinColumn(name = "role_id"),
            inverseJoinColumns = @JoinColumn(name = "permission_id")
    )
    private Set<Permission> permissions;

}
