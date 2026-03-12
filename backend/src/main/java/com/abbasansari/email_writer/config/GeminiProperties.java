package com.abbasansari.email_writer.config;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.ToString;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.validation.annotation.Validated;

import java.time.Duration;

@Data
@Validated
@ConfigurationProperties(prefix = "replai.gemini")
public class GeminiProperties {

    @NotBlank(message = "Gemini base URL must be configured")
    private String baseUrl;

    @NotBlank(message = "Gemini model must be configured")
    private String model;

    @NotBlank(message = "Gemini API key must be configured")
    @ToString.Exclude
    private String apiKey;

    @Min(value = 1000, message = "Request timeout must be at least 1000ms")
    private long requestTimeoutMs = 15_000;

    private Duration connectTimeout = Duration.ofSeconds(3);
}
