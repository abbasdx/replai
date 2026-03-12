package com.abbasansari.email_writer.exception;

public class ExternalServiceException extends RuntimeException {

    private final boolean transientFailure;

    public ExternalServiceException(String message) {
        super(message);
        this.transientFailure = false;
    }

    public ExternalServiceException(String message, Throwable cause) {
        super(message, cause);
        this.transientFailure = false;
    }

    public ExternalServiceException(String message, Throwable cause, boolean transientFailure) {
        super(message, cause);
        this.transientFailure = transientFailure;
    }

    public ExternalServiceException(String message, boolean transientFailure) {
        super(message);
        this.transientFailure = transientFailure;
    }

    public boolean isTransientFailure() {
        return transientFailure;
    }
}
