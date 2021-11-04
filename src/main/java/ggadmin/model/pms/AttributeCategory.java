package ggadmin.model.pms;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "attribute_category", schema = "pms")
public class AttributeCategory implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(name = "name", unique = true, nullable = false)
    private String name;

    @Column(name = "attribute_count")
    private Integer attributeCount;

    @Column(name = "param_count")
    private Integer paramCount;

    @OneToMany(mappedBy = "attributeCategory", fetch = FetchType.LAZY)
    private List<Attribute> attributeList;

    @Override
    public String toString() {
        return "AttributeCategory{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", attributeCount=" + attributeCount +
                ", paramCount=" + paramCount +
                '}';
    }
}
