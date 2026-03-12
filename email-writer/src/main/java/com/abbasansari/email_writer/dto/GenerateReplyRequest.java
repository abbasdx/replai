package com.abbasansari.email_writer.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record GenerateReplyRequest(
        @NotBlank(message = "Email content must not be empty")
        @Size(min = 30, max = 4000, message = "Email content must be between 30 and 4000 characters")
        String emailContent,

        @Size(max = 30, message = "Tone must be 30 characters or less")
        String tone
) {
}

