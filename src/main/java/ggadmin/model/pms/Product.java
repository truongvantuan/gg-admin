package ggadmin.model.pms;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "product", schema = "pms")
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "product_sn", nullable = false)
    private String productSn;

    @Column(name = "picture")
    private String picture;

    @Column(name = "delete_status")
    private Integer deleteStatus;

    @Column(name = "publish_status")
    private Integer publishStatus;

    @Column(name = "new_status")
    private Integer newStatus;

    @Column(name = "recommended_status")
    private Integer recommendedStatus;

    @Column(name = "verify_status")
    private Integer verifyStatus;

    @Column(name = "sort")
    private Integer sort;

    @Column(name = "sale")
    private Integer sale;

    @Column(name = "price")
    private BigDecimal price;

    @Column(name = "promotion_price")
    private BigDecimal promotionPrice;

    @Column(name = "gift_growth")
    private Integer giftGrowth;

    @Column(name = "gift_point")
    private Integer giftPoint;

    @Column(name = "use_point_limit")
    private Integer usePointLimit;

    @Column(name = "subtitle")
    private String subtitle;

    @Column(name = "description")
    private String description;

    @Column(name = "original_price")
    private BigDecimal originalPrice;

    @Column(name = "stock")
    private Integer stock;

    @Column(name = "low_stock")
    private Integer lowStock;

    @Column(name = "unit")
    private String unit;

    @Column(name = "weight")
    private BigDecimal weight;

    @Column(name = "preview_status")
    private Integer previewStatus;

    @Column(name = "service_ids")
    private String serviceIds;

    @Column(name = "keywords")
    private String keywords;

    @Column(name = "note")
    private String note;

    @Column(name = "album_pics")
    private String albumPics;

    @Column(name = "detail_title")
    private String detailTitle;

    @Column(name = "detail_desc")
    private String detailDesc;

    @Column(name = "detail_html")
    private String detailHtml;

    @Column(name = "detail_mobile_html")
    private String detailMobileHtml;

    @Column(name = "promotion_start_time")
    private Date promotionStartTime;

    @Column(name = "promotion_end_time")
    private Date promotionEndTime;

    @Column(name = "promotion_per_limit")
    private Integer promotionPerLimit;

    @Column(name = "promotion_type")
    private Integer promotionType;

    @Column(name = "product_category_name")
    private String productCategoryName;

    @Column(name = "brand_name")
    private String brandName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "brand_id", nullable = false)
    private Brand brand;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @ManyToOne
    @JoinColumn(name = "attribute_category_id")
    private AttributeCategory attributeCategory;

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    @OneToMany(mappedBy = "product")
    private Set<ProductLadder> productLadders = new HashSet<>();
}
