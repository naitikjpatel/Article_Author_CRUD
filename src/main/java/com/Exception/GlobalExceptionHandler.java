package com.Exception;

import com.Service.EmailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @Autowired
    private EmailService emailService;

    @ExceptionHandler(Exception.class)
    public String handleException(Exception ex, Model model) {
        logger.error("Unhandled exception: ", ex.getMessage());
        model.addAttribute("errorMessage", "Something went wrong. Please try again.");

       
        String subject = "Unhandled Exception in Application";
        String body = "Exception occurred:\n\n" + ex.getMessage().toString();

        emailService.sendNotification(subject, body);

        return "error";
    }
}
