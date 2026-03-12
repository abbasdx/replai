package com.abbasansari.email_writer.config;

import io.netty.channel.ChannelOption;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.netty.http.client.HttpClient;

import java.time.Duration;

@Configuration
@RequiredArgsConstructor
public class WebClientConfig {

	private final GeminiProperties geminiProperties;

	@Bean
	public WebClient webClient(WebClient.Builder builder) {
		HttpClient httpClient = HttpClient.create()
				.option(ChannelOption.CONNECT_TIMEOUT_MILLIS, (int) geminiProperties.getConnectTimeout().toMillis())
				.responseTimeout(Duration.ofMillis(geminiProperties.getRequestTimeoutMs()));

		return builder.clientConnector(new ReactorClientHttpConnector(httpClient)).build();
	}
}
