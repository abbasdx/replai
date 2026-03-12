package com.abbasansari.email_writer.config;

import jakarta.validation.constraints.Min;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.validation.annotation.Validated;

@Data
@Validated
@ConfigurationProperties(prefix = "replai.rate-limit")
public class RateLimitProperties {

    @Min(value = 1, message = "Rate limit capacity must be at least 1")
    private long capacity = 60;

    @Min(value = 1, message = "Rate limit refill tokens must be at least 1")
    private long refillTokens = 60;

    @Min(value = 1, message = "Rate limit refill duration seconds must be at least 1")
    private long refillDurationSeconds = 60;
}
