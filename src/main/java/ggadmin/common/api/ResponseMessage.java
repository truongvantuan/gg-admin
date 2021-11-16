package ggadmin.common.api;

public enum ResponseMessage {

    SUCCESS(200, "Success operation!"),
    FAILED(500, "Failed operation!");

    private Integer code;
    private String message;

    ResponseMessage(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public Integer getCode() {
        return code;
    }
}
