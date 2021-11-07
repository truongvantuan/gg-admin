package ggadmin.model.ums;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name = "resource_category")
public class ResourceCategory implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "create_time")
    private Date createTime;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "sort")
    private Long sort;

}
