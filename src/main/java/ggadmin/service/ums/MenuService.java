package ggadmin.service.ums;

import ggadmin.model.ums.Menu;
import org.springframework.data.domain.Page;

import java.util.List;

public interface MenuService {

    List<Menu> getRootMenu();

    List<Menu> getMenuTree();

    Page<Menu> getRootMenuPage(Integer pageNum, Integer pageSize);

    Page<Menu> getMenuPage(Long rootMenuId, Integer pageNum, Integer pageSize);

    boolean updateHiddenStatus(Long menuId, Integer hiddenStatus);

    Menu getMenu(Long menuId);
}
