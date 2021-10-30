package ggadmin.model.pms;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

@Getter
@Setter
@Entity
@Table(name = "attribute", schema = "pms")
public class Attribute implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(name = "attribute_category_id")
    private Long attributeCategoryId;

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



    @Override
    public String toString() {
        return "Attribute{" +
                "id=" + id + '\'' +
                "attributeCategoryId=" + attributeCategoryId + '\'' +
                "name=" + name + '\'' +
                "selectType=" + selectType + '\'' +
                "inputType=" + inputType + '\'' +
                "inputList=" + inputList + '\'' +
                "sort=" + sort + '\'' +
                "filterType=" + filterType + '\'' +
                "searchType=" + searchType + '\'' +
                "relatedStatus=" + relatedStatus + '\'' +
                "handAddStatus=" + handAddStatus + '\'' +
                "type=" + type + '\'' +
                '}';
    }
}
