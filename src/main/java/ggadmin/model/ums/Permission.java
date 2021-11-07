package ggadmin.model.ums;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "permission", schema = "ums")
@NamedNativeQueries(
        @NamedNativeQuery(
                name = "getPermissionsByAdminId",
                query = "SELECT P.* FROM ums.admin_role_relation ar LEFT JOIN ums.role r ON ar.role_id = r.ID LEFT JOIN ums.role_permission_relation rp ON r.ID = rp.role_id LEFT JOIN ums.permission P ON rp.permission_id = P.ID WHERE ar.admin_id = ?1 AND P.ID IS NOT NULL AND P.ID NOT IN ( SELECT P.ID FROM ums.admin_permission_relation pr LEFT JOIN ums.permission P ON pr.permission_id = P.ID WHERE pr.TYPE = - 1 AND pr.admin_id = ?1) UNION SELECT P.* FROM ums.admin_permission_relation pr LEFT JOIN ums.permission P ON pr.permission_id = P.ID WHERE pr.TYPE = 1 AND pr.admin_id = ?1",
                resultClass = Permission.class
        )
)
public class Permission implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "value")
    private String value;

    @Column(name = "icon")
    private String icon;

    @Column(name = "type", nullable = false)
    private Integer type;

    @Column(name = "uri")
    private String uri;

    @Column(name = "status", nullable = false)
    private Integer status;

    @Column(name = "create_time", nullable = false)
    private Date createTime;

    @Column(name = "sort")
    private Integer sort;

    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Permission parentPermission;

    @ManyToMany(mappedBy = "permissions")
    @JsonIgnore
    private Set<Admin> admins;

    @ManyToMany(mappedBy = "permissions")
    @JsonIgnore
    private Set<Role> roles;

}
