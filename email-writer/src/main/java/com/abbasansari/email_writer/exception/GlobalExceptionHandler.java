package com.abbasansari.email_writer.exception;

import com.abbasansari.email_writer.dto.ApiResponse;
import jakarta.servlet.http.HttpServletRequest;
import io.github.resilience4j.circuitbreaker.CallNotPermittedException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.List;
import java.util.stream.Collectors;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiResponse<Object>> handleValidationException(
            MethodArgumentNotValidException ex,
            HttpServletRequest request) {

        List<String> errors = ex.getBindingResult().getFieldErrors().stream()
                .map(fieldError -> fieldError.getField() + ": " + fieldError.getDefaultMessage())
                .collect(Collectors.toList());

        return ResponseEntity.badRequest().body(ApiResponse.error(
                "Validation failed",
                errors,
                request.getRequestURI()
        ));
    }

    @ExceptionHandler(ExternalServiceException.class)
    public ResponseEntity<ApiResponse<Object>> handleExternalServiceException(
            ExternalServiceException ex,
            HttpServletRequest request) {

        return ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(ApiResponse.error(
                ex.getMessage(),
                List.of(),
                request.getRequestURI()
        ));
    }

    @ExceptionHandler(RateLimitExceededException.class)
    public ResponseEntity<ApiResponse<Object>> handleRateLimitExceeded(
            RateLimitExceededException ex,
            HttpServletRequest request) {

        return ResponseEntity.status(HttpStatus.TOO_MANY_REQUESTS).body(ApiResponse.error(
                ex.getMessage(),
                List.of(),
                request.getRequestURI()
        ));
    }

    @ExceptionHandler(CallNotPermittedException.class)
    public ResponseEntity<ApiResponse<Object>> handleCircuitBreakerOpen(
            CallNotPermittedException ex,
            HttpServletRequest request) {

        return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).body(ApiResponse.error(
                "Gemini is temporarily unavailable. Please retry shortly.",
                List.of(),
                request.getRequestURI()
        ));
    }
}
