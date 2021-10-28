package ggadmin.exception.ums;

public class AdminExistException extends RuntimeException {

    private String message;

    public AdminExistException(String message) {
        super(message);
        this.message = message;
    }

    public AdminExistException() {
    }
}
