package ggadmin.model.pms;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;

@Getter
@Setter
@Entity
@Table(name = "attribute", schema = "pms")
public class Attribute implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "select_type")
    private Integer selectType;

    @Column(name = "input_type")
    private Integer inputType;

    @Column(name = "input_list")
    private String inputList;

    @Column(name = "sort")
    private Integer sort;

    @Column(name = "filter_type")
    private Integer filterType;

    @Column(name = "search_type")
    private Integer searchType;

    @Column(name = "related_status")
    private Integer relatedStatus;

    @Column(name = "hand_add_status")
    private Integer handAddStatus;

    @Column(name = "type")
    private Integer type;

    @ManyToMany(mappedBy = "attributes", fetch = FetchType.LAZY)
    private Collection<Category> categories = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "attribute_category_id")
    private AttributeCategory attributeCategory;

}
