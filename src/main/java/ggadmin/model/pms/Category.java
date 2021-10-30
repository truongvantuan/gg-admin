package ggadmin.model.pms;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * bảng danh mục sản phẩm
 */
@Entity
@Table(name = "category")
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "pid")
    private Long pid;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "level")
    private Integer level;

    @Column(name = "product_count")
    private Integer productCount;

    @Column(name = "product_unit")
    private Integer productUnit;

    @Column(name = "nav_status")
    private Integer navStatus;

    @Column(name = "show_status")
    private Integer showStatus;

    @Column(name = "sort")
    private Integer sort;

    @Column(name = "icon")
    private String icon;

    @Column(name = "keywords")
    private String keywords;

    @Column(name = "description")
    private String description;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    /**
     * id của category mẹ, giá trị 0 là root_category
     */
    public void setPid(Long pid) {
        this.pid = pid;
    }

    /**
     * id của category mẹ, giá trị 0 là root_category
     */
    public Long getPid() {
        return pid;
    }

    /**
     * tên category
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * tên category
     */
    public String getName() {
        return name;
    }

    /**
     * cấp bậc phân loại: 0->level1, 1->level2
     */
    public void setLevel(Integer level) {
        this.level = level;
    }

    /**
     * cấp bậc phân loại: 0->level1, 1->level2
     */
    public Integer getLevel() {
        return level;
    }

    /**
     * số sản phẩm thuộc có
     */
    public void setProductCount(Integer productCount) {
        this.productCount = productCount;
    }

    /**
     * số sản phẩm thuộc có
     */
    public Integer getProductCount() {
        return productCount;
    }

    /**
     * đơn vị một sản phẩm
     */
    public void setProductUnit(Integer productUnit) {
        this.productUnit = productUnit;
    }

    /**
     * đơn vị một sản phẩm
     */
    public Integer getProductUnit() {
        return productUnit;
    }

    /**
     * trạng thái hiển thị trên navigation bar: 0->ẩn, 1->hiện
     */
    public void setNavStatus(Integer navStatus) {
        this.navStatus = navStatus;
    }

    /**
     * trạng thái hiển thị trên navigation bar: 0->ẩn, 1->hiện
     */
    public Integer getNavStatus() {
        return navStatus;
    }

    /**
     * trạng thái hiển thị: 0->ẩn, 1->hiển thị
     */
    public void setShowStatus(Integer showStatus) {
        this.showStatus = showStatus;
    }

    /**
     * trạng thái hiển thị: 0->ẩn, 1->hiển thị
     */
    public Integer getShowStatus() {
        return showStatus;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getSort() {
        return sort;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getIcon() {
        return icon;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id + '\'' +
                "pid=" + pid + '\'' +
                "name=" + name + '\'' +
                "level=" + level + '\'' +
                "productCount=" + productCount + '\'' +
                "productUnit=" + productUnit + '\'' +
                "navStatus=" + navStatus + '\'' +
                "showStatus=" + showStatus + '\'' +
                "sort=" + sort + '\'' +
                "icon=" + icon + '\'' +
                "keywords=" + keywords + '\'' +
                "description=" + description + '\'' +
                '}';
    }
}
