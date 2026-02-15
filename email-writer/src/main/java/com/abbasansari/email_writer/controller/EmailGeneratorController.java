package com.abbasansari.email_writer.controller;

import com.abbasansari.email_writer.model.ApiResponse;
import com.abbasansari.email_writer.model.EmailRequest;
import com.abbasansari.email_writer.service.EmailGeneratorService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/email")
@AllArgsConstructor
@CrossOrigin(origins = "*")
public class EmailGeneratorController {

    private final EmailGeneratorService emailGeneratorService;

    @GetMapping
    public String home() {
        return "Email Reply Generator API is running...";
    }

    @PostMapping("/generate")
    public ResponseEntity<ApiResponse> generateEmail(
            @Valid @RequestBody EmailRequest emailRequest) {

        String response = emailGeneratorService.generateEmailReply(emailRequest);

        ApiResponse apiResponse = new ApiResponse(
                true,
                "Email generated successfully",
                response
        );

        return ResponseEntity.ok(apiResponse);
    }
}