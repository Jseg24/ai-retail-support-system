package com.example.retail_support.service;

import org.springframework.stereotype.Service;

@Service
public class AIService {

    public String classifyTicket(String description) {
        // Later this will call the AI API
        return "INVENTORY";
    }
}