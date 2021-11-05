package ggadmin.model.pms;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * giảm giá toàn bộ sản phẩm (chỉ các sản phẩm cùng loại)
 */
@Getter
@Setter
@Entity
@Table(name = "product_full_reduction", schema = "pms")
public class ProductFullReduction implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(name = "full_price", nullable = false)
    private BigDecimal fullPrice;

    @Column(name = "reduce_price", nullable = false)
    private BigDecimal reducePrice;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

}
