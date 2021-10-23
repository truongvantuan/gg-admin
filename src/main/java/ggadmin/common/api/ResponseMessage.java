package ggadmin.common.api;

public enum ResponseMessage {

    SUCCESS("Success operation!"),
    FAILED("Failed operation!");

    private String message;

    ResponseMessage(String s) {
    }

    public String getMessage() {
        return message;
    }
}
