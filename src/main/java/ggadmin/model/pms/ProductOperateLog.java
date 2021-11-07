package ggadmin.model.pms;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * bảng lưu lịch sử thay đổi thông tin giá sản phẩm
 */
@Getter
@Setter
@Entity
@Table(name = "product_operate_log", schema = "pms")
public class ProductOperateLog implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "price_old")
    private BigDecimal priceOld;

    @Column(name = "price_new")
    private BigDecimal priceNew;

    @Column(name = "sale_price_old")
    private BigDecimal salePriceOld;

    @Column(name = "sale_price_new")
    private BigDecimal salePriceNew;

    @Column(name = "gift_point_old")
    private Integer giftPointOld;

    @Column(name = "gift_point_new")
    private Integer giftPointNew;

    @Column(name = "use_point_limit_old")
    private Integer usePointLimitOld;

    @Column(name = "use_point_limit_new")
    private Integer usePointLimitNew;

    @Column(name = "operate_man")
    private String operateMan;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_time")
    private Date createTime;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

}
