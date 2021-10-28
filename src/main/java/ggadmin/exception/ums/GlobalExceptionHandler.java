package ggadmin.exception.ums;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @Value("${data.exception.user_exist}")
    private String user_exist;

    @ExceptionHandler(AdminExistException.class)
    public ResponseEntity<?> adminExistingException(AdminExistException adminExistException) {
        return new ResponseEntity<>(user_exist, HttpStatus.IM_USED);
    }
}
