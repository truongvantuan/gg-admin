package ggadmin.common.api;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.ResponseEntity;

import java.util.HashMap;
import java.util.Map;

/**
 * Định nghĩa cấu trúc kết quả chung trả về cho client
 *
 * @param <T>
 */

@Getter
@Setter
public class CommonResult<T> {

    private Integer code;
    private String message;
    private T data;

    public CommonResult(Integer code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public static <T> ResponseEntity<?> success(T data) {
        Map<String, Object> dataMap = prepareResult(ResponseMessage.SUCCESS.getCode(), ResponseMessage.SUCCESS.getMessage(), data);
        return ResponseEntity.ok().body(dataMap);
    }

    public static <T> ResponseEntity<?> success(T data, String message) {
        Map<String, Object> dataMap = prepareResult(ResponseMessage.SUCCESS.getCode(), message, data);
        return ResponseEntity.ok().body(dataMap);
    }

    public static ResponseEntity<?> failed(String message) {
        Map<String, Object> dataMap = prepareResult(ResponseMessage.FAILED.getCode(), message, null);
        return ResponseEntity.status(500).body(dataMap);
    }

    public static ResponseEntity<?> failed() {
        Map<String, Object> dataMap = prepareResult(ResponseMessage.FAILED.getCode(), ResponseMessage.FAILED.getMessage(), null);
        return ResponseEntity.status(500).body(dataMap);
    }

    public static <T> Map<String, Object> prepareResult(Integer code, String message, T data) {
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("code", code);
        dataMap.put("message", message);
        dataMap.put("data", data);
        return dataMap;
    }
}
