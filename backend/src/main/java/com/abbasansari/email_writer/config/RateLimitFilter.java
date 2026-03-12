package com.abbasansari.email_writer.config;

import com.abbasansari.email_writer.exception.RateLimitExceededException;
import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Bucket;
import io.github.bucket4j.Refill;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.time.Duration;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

@Component
public class RateLimitFilter extends OncePerRequestFilter {

    private static final String REPLY_API_PREFIX = "/api/v1/replies/";
    private static final String X_FORWARDED_FOR = "X-Forwarded-For";

    private final RateLimitProperties rateLimitProperties;
    private final HandlerExceptionResolver exceptionResolver;
    private final ConcurrentMap<String, Bucket> bucketsByIp = new ConcurrentHashMap<>();

    public RateLimitFilter(
            RateLimitProperties rateLimitProperties,
            @Qualifier("handlerExceptionResolver") HandlerExceptionResolver exceptionResolver) {
        this.rateLimitProperties = rateLimitProperties;
        this.exceptionResolver = exceptionResolver;
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        return !request.getRequestURI().startsWith(REPLY_API_PREFIX);
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        String clientIp = extractClientIp(request);
        Bucket bucket = bucketsByIp.computeIfAbsent(clientIp, ignored -> createBucket());
        boolean allowed = bucket.tryConsume(1);

        if (!allowed) {
            exceptionResolver.resolveException(
                    request,
                    response,
                    null,
                    new RateLimitExceededException("Rate limit exceeded. Please retry after some time.")
            );
            return;
        }

        filterChain.doFilter(request, response);
    }

    private Bucket createBucket() {
        Refill refill = Refill.greedy(
                rateLimitProperties.getRefillTokens(),
                Duration.ofSeconds(rateLimitProperties.getRefillDurationSeconds())
        );
        Bandwidth limit = Bandwidth.classic(rateLimitProperties.getCapacity(), refill);
        return Bucket.builder()
                .addLimit(limit)
                .build();
    }

    private String extractClientIp(HttpServletRequest request) {
        String forwarded = request.getHeader(X_FORWARDED_FOR);
        if (forwarded != null && !forwarded.isBlank()) {
            return forwarded.split(",")[0].trim();
        }
        return request.getRemoteAddr();
    }
}
