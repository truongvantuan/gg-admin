package ggadmin.dto;


import ggadmin.model.ums.Menu;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class AdminInfoDTO {

    private String username;

    private String icon;

    private List<String> roles;

    private List<Menu> menus;

}
