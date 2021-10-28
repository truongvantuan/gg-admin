package ggadmin.common.api;

import org.springframework.http.ResponseEntity;

import java.util.HashMap;
import java.util.Map;

public class CommonResult<T> {

    private String message;
    private T data;

    public CommonResult(String message, T data) {
        this.message = message;
        this.data = data;
    }

    public static <T> ResponseEntity<?> success(T data) {
        Map<String, Object> dataMap = prepareResult(data, ResponseMessage.SUCCESS.getMessage());
        return ResponseEntity.ok().body(dataMap);
    }

    public static <T> ResponseEntity<?> success(T data, String message) {
        Map<String, Object> dataMap = prepareResult(data, message);
        return ResponseEntity.ok().body(dataMap);
    }

    public static ResponseEntity<?> failed(String message) {
        Map<String, Object> dataMap = prepareResult(null, message);
        return ResponseEntity.status(500).body(dataMap);
    }

    public static ResponseEntity<?> failed() {
        Map<String, Object> dataMap = prepareResult(null, ResponseMessage.FAILED.getMessage());
        return ResponseEntity.status(500).body(dataMap);
    }

    public static <T> Map<String, Object> prepareResult(T data, String message) {
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("message", message);
        dataMap.put("data", data);
        return dataMap;
    }
}

/**
 * public static <T> ResponseEntity<?> success(T data) {
 * Map<String, Object> dataMap = new HashMap<>();
 * dataMap.put("data", data);
 * dataMap.put("message", ResponseMessage.SUCCESS.getMessage());
 * return ResponseEntity.ok().body(dataMap);
 * }
 */
