package ggadmin.model.ums;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
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
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "menu", schema = "ums")
public class Menu implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "parent_id")
    private Long parentId;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_time")
    private Date createTime;

    @Column(name = "title")
    private String title;

    @Column(name = "level")
    private Integer level;

    @Column(name = "sort")
    private Integer sort;

    @Column(name = "name")
    private String name;

    @Column(name = "icon")
    private String icon;

    @Column(name = "hidden")
    private Integer hidden;

    @ManyToMany(mappedBy = "menus")
    @JsonIgnore
    private Collection<Role> roles;

}
