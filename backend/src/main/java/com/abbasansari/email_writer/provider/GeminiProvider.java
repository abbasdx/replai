package com.abbasansari.email_writer.provider;

import com.abbasansari.email_writer.config.GeminiProperties;
import com.abbasansari.email_writer.exception.ExternalServiceException;
import com.fasterxml.jackson.databind.JsonNode;
import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import io.github.resilience4j.retry.annotation.Retry;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientRequestException;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class GeminiProvider implements AiProvider {

    private final WebClient webClient;
    private final GeminiProperties geminiProperties;

    @Override
    @Retry(name = "gemini")
    @CircuitBreaker(name = "gemini")
    public String generateReply(String prompt) {
        Map<String, Object> body = Map.of(
                "contents", List.of(Map.of("parts", List.of(Map.of("text", prompt)))),
                "generationConfig", Map.of("temperature", 0.4, "maxOutputTokens", 1024));
        try {
            JsonNode response = webClient.post()
                    .uri(geminiProperties.getBaseUrl() + "/" + geminiProperties.getModel() + ":generateContent")
                    .header("x-goog-api-key", geminiProperties.getApiKey())
                    .contentType(MediaType.APPLICATION_JSON)
                    .bodyValue(body)
                    .retrieve()
                    .onStatus(status -> status.isError(),
                            r -> Mono.error(toException(r.statusCode().value())))
                    .bodyToMono(JsonNode.class)
                    .block();
            return extractText(response);
        } catch (WebClientRequestException e) {
            throw new ExternalServiceException("Gemini service is temporarily unreachable", e, true);
        }
    }

    private String extractText(JsonNode response) {
        String text = response == null ? "" : response.path("candidates").path(0)
                .path("content").path("parts").path(0).path("text").asText("");
        if (!StringUtils.hasText(text)) {
            throw new ExternalServiceException("Gemini response did not include reply text");
        }
        return text.trim();
    }

    private ExternalServiceException toException(int status) {
        if (status == 429 || status >= 500) {
            return new ExternalServiceException("Gemini is temporarily unavailable. Please retry shortly.", true);
        }
        return new ExternalServiceException("Gemini rejected the request", false);
    }
}
