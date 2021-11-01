package ggadmin.model.pms;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

@Getter
@Setter
@Entity
@Table(name = "category", schema = "pms")
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
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
