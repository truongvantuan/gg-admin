package ggadmin.common.api;

import lombok.Data;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Class xác định cấu trúc chung (common format) một Page trả về cho Client
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
        // page trong JPA đếm từ 0, cần cộng thêm 1 để trả về client hiển thị đúng thứ tự từ tang 1
        commonPage.setPageNum(page.getNumber() + 1);
        commonPage.setPageSize(page.getSize());
        commonPage.setTotalPage(page.getTotalPages());
        commonPage.setTotal(page.getTotalElements());
        commonPage.setList(page.getContent());
        return commonPage;
    }
}
