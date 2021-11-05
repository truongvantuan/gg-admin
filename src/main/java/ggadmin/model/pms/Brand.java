package ggadmin.model.pms;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "brand", schema = "pms")
public class Brand implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
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
    private Integer productCount;

    @Column(name = "product_comment_count", nullable = false)
    private Integer productCommentCount;

    @Column(name = "logo")
    private String logo;

    @Column(name = "big_pic")
    private String bigPic;

    @Column(name = "brand_story")
    private String brandStory;

    /**
     * Lấy danh sách Product sử dụng Foreign Key được map bởi thuộc tính "brand" phía Product
     */
    @OneToMany(mappedBy = "brand", fetch = FetchType.LAZY)
    List<Product> productList = new ArrayList<>();

    public List<Product> getProductList() {
        return productList;
    }

    public void addProduct(Product product) {
        this.productList.add(product);
    }
}
