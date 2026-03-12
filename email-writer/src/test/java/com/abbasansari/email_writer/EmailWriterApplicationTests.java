package com.abbasansari.email_writer;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

@SpringBootTest
@TestPropertySource(properties = {
		"replai.gemini.base-url=https://generativelanguage.googleapis.com/v1beta/models",
		"replai.gemini.model=gemini-1.5-flash",
		"replai.gemini.api-key=test-key",
		"replai.gemini.request-timeout-ms=15000",
		"replai.gemini.connect-timeout=3s"
})
class EmailWriterApplicationTests {

	@Test
	void contextLoads() {
	}

}
