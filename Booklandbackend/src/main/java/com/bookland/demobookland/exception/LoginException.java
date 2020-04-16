package com.bookland.demobookland.exception;

public class LoginException extends RuntimeException {

    private String message;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}