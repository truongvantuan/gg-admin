package ggadmin.model.ums;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

/**
 * bảng quản lý menu ở hiển thị theo Admin
 */
@Getter
@Setter
@Entity
@Table(name = "menu", schema = "ums")
public class Menu implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_time")
    private Date createTime;

    @Column(name = "title")
    private String title;

    @Column(name = "level")
    private Long level;

    @Column(name = "sort")
    private Long sort;

    @Column(name = "name")
    private String name;

    @Column(name = "icon")
    private String icon;

    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Menu parentMenu;

    @ManyToMany(mappedBy = "menus")
    @JsonIgnore
    private Collection<Role> roles;

}
