package com.abbasansari.email_writer.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class EmailRequest {

    @NotBlank(message = "Email content must not be empty")
    @Size(min = 30, max = 3000, message = "Email content must be between 30 and 2000 characters")
    private String emailContent;
    private String tone;
}
