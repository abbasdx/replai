package com.abbasansari.email_writer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@ConfigurationPropertiesScan
@EnableCaching
public class EmailWriterApplication {
	public static void main(String[] args) {
		SpringApplication.run(EmailWriterApplication.class, args);
	}

}
