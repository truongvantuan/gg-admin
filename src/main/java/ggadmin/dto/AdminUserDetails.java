package ggadmin.dto;

import ggadmin.model.ums.Admin;
import ggadmin.model.ums.Permission;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

public class AdminUserDetails implements UserDetails {

    private Admin admin;

    private List<Permission> permissions;

    public AdminUserDetails(Admin admin, List<Permission> permissions) {
        this.admin = admin;
        this.permissions = permissions;
    }

    /**
     * Lấy ra các phân quyền được sở hữu bởi Admin.
     * Thực tế nó là permissions trong database.
     * @return
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.permissions.stream()
                .filter(permission -> permission.getValue() != null)
                .map(permission -> new SimpleGrantedAuthority(permission.getValue()))
                .collect(Collectors.toList());
    }

    @Override
    public String getPassword() {
        return admin.getPassword();
    }

    @Override
    public String getUsername() {
        return admin.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return false;
    }

    @Override
    public boolean isAccountNonLocked() {
        return false;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    public boolean isEnabled() {
        return admin.getStatus() == 1;
    }
}
