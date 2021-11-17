package ggadmin.dto.ums;

import ggadmin.model.ums.Menu;
import ggadmin.model.ums.Role;
import lombok.Builder;
import lombok.Data;

import java.util.Set;
import java.util.stream.Collectors;

@Data
@Builder
public class AdminInfo {

    private String username;

    private String icon;

    private Set<Role> roles;

    private Set<Menu> menus;

}
