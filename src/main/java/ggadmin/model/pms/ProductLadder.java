package ggadmin.model.pms;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * danh sách thang giá sản phẩm (sản phẩm cùng loại)
 */
@Getter
@Setter
@Entity
@Table(name = "product_ladder", schema = "pms")
public class ProductLadder implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(name = "count", nullable = false)
    private Long count;

    @Column(name = "discount")
    private BigDecimal discount;

    @Column(name = "price")
    private BigDecimal price;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

}
