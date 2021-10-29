package ggadmin.model.pms;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;


@Data
@Entity
@Table(name = "brand", schema = "pms")
public class Brand implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "first_letter", nullable = false)
    private String firstLetter;

    @Column(name = "sort", nullable = false)
    private Integer sort;

    @Column(name = "factory_status", nullable = false)
    private Integer factoryStatus;

    @Column(name = "show_status", nullable = false)
    private Integer showStatus;

    @Column(name = "product_count", nullable = false)
    private Long productCount;

    @Column(name = "product_comment_count", nullable = false)
    private Long productCommentCount;

    @Column(name = "logo")
    private String logo;

    @Column(name = "big_pic")
    private String bigPic;

    @Column(name = "brand_story")
    private String brandStory;

}
