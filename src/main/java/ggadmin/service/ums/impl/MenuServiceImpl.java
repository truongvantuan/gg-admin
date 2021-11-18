package ggadmin.service.ums.impl;

import ggadmin.model.ums.Menu;
import ggadmin.repository.ums.MenuRepository;
import ggadmin.service.ums.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuRepository menuRepository;

    @Override
    public List<Menu> getRootMenu() {
        return menuRepository.getAllByParentIdIs(0L);
    }

    @Override
    public List<Menu> getMenuTree() {
        return menuRepository.getAllByParentIdIs(0L);
    }

    @Override
    public Page<Menu> getRootMenuPage(Integer pageNum, Integer pageSize) {
        --pageNum;
        Pageable paging = PageRequest.of(pageNum, pageSize);
        Page<Menu> menuPage = menuRepository.getAllByParentIdIs(0L, paging);
        return menuPage;
    }

    @Override
    public Page<Menu> getMenuPage(Long rootMenuId, Integer pageNum, Integer pageSize) {
        --pageNum;
        Pageable paging = PageRequest.of(pageNum, pageSize);
        Page<Menu> menuPage = menuRepository.getAllByParentIdIs(rootMenuId, paging);
        return menuPage;
    }

    @Override
    public boolean updateHiddenStatus(Long menuId, Integer hiddenStatus) {
        Menu menu = menuRepository.getById(menuId);
        menu.setHidden(hiddenStatus);
        boolean isUpdated = true;
        try {
            menuRepository.save(menu);
        } catch (RuntimeException e) {
            isUpdated = false;
        }
        return isUpdated;
    }

    @Override
    public Menu getMenu(Long menuId) {
        Menu menu = menuRepository.findById(menuId).get();
        return menu;
    }
}
