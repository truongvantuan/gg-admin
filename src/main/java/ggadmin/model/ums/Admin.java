package ggadmin.model.ums;

import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;
import java.util.Set;

@Data
@Entity
@Table(name = "admin", schema = "ums")
public class Admin implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotNull
    @Size(min = 6, max = 30, message = "Name must be at least 6 characters long")
    @Column(name = "username")
    private String username;

    @NotNull
    @Column(name = "password")
    private String password;

    @NotNull
    @Email
    @Column(name = "email")
    private String email;

    @Column(name = "icon")
    private String icon;

    @Column(name = "nick_name")
    private String nickName;

    @Column(name = "note")
    private String note;

    @NotNull
    @Column(name = "create_time")
    private Date createTime;

    @Column(name = "login_time")
    private Date loginTime;

    @NotNull
    @Column(name = "status")
    private Integer status;

    @ManyToMany(cascade = CascadeType.PERSIST)
    @JoinTable(
            name = "admin_role_relation",
            joinColumns = @JoinColumn(name = "admin_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id")
    )
    private Set<Role> roles;

    @ManyToMany(fetch = FetchType.LAZY, mappedBy = "admins")
    private Set<Permission> permissions;

    public Set<Permission> getPermissions() {
        return permissions;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }
}
