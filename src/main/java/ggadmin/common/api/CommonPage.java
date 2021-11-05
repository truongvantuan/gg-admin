package ggadmin.common.api;

import lombok.Data;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Class xác định cấu trúc chung một Page trả về cho Client
 * @param <T> page của đối tượng generic T
 */

@Data
public class CommonPage<T> {

    private Integer pageNum;

    private Integer pageSize;

    private Integer totalPage;

    private Long total;

    private List<T> list;

    public static <T> CommonPage<T> restPage(Page<T> page) {
        CommonPage<T> commonPage = new CommonPage<>();
        commonPage.setPageNum(page.getNumber());
        commonPage.setPageSize(page.getSize());
        commonPage.setTotalPage(page.getTotalPages());
        commonPage.setTotal(page.getTotalElements());
        commonPage.setList(page.getContent());
        return commonPage;
    }
}
