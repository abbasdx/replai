package com.abbasansari.email_writer.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record ImproveReplyRequest(
        @NotBlank(message = "Reply content must not be empty")
        @Size(min = 30, max = 4000, message = "Reply content must be between 30 and 4000 characters")
        String replyContent,

        @NotBlank(message = "Improvement instruction must not be empty")
        @Size(max = 100, message = "Improvement instruction must be 100 characters or less")
        String instruction
) {
}

