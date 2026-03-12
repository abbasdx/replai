package com.abbasansari.email_writer.controller;

import com.abbasansari.email_writer.dto.GenerateReplyRequest;
import com.abbasansari.email_writer.dto.ImproveReplyRequest;
import com.abbasansari.email_writer.dto.ApiResponse;
import com.abbasansari.email_writer.service.ReplyGenerationService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/replies")
@RequiredArgsConstructor
public class ReplyController {

    private final ReplyGenerationService replyGenerationService;

    @PostMapping("/generate")
    public ResponseEntity<ApiResponse<String>> generate(
            @Valid @RequestBody GenerateReplyRequest request,
            HttpServletRequest servletRequest) {

        String reply = replyGenerationService.generateReply(request);
        return ResponseEntity.ok(ApiResponse.success(
                "Reply generated successfully",
                reply,
                servletRequest.getRequestURI()
        ));
    }

    @PostMapping("/improve")
    public ResponseEntity<ApiResponse<String>> improve(
            @Valid @RequestBody ImproveReplyRequest request,
            HttpServletRequest servletRequest) {

        String reply = replyGenerationService.improveReply(request);
        return ResponseEntity.ok(ApiResponse.success(
                "Reply improved successfully",
                reply,
                servletRequest.getRequestURI()
        ));
    }
}
