package ggadmin.model.pms;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * biểu mẫu vận chuyển hàng hóa
 */
@Getter
@Setter
@Entity
@Table(name = "weight_template", schema = "pms")
public class WeightTemplate implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "charge_type", nullable = false)
    private Integer chargeType;

    @Column(name = "first_weight")
    private BigDecimal firstWeight;

    @Column(name = "first_fee")
    private BigDecimal firstFee;

    @Column(name = "continue_weight")
    private BigDecimal continueWeight;

    @Column(name = "continue_fee")
    private BigDecimal continueFee;

    @Column(name = "dest")
    private String dest;

}
