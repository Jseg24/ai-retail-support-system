package com.example.retail_support.service;



import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.retail_support.model.Ticket;

import tools.jackson.databind.JsonNode;
import tools.jackson.databind.ObjectMapper;

@Service
public class AIService {

    private final HttpClient httpClient = HttpClient.newHttpClient();

    @Value("${ai.api.url}")
    private String apiUrl;

    @Value("${ai.api.key}")
    private String apiKey;

    @Value("${ai.model}")
    private String model;

    public Ticket analyzeTicket(Ticket ticket){

        try {

         String requestBody = """
{
  "model": "%s",
  "messages": [
    {
      "role": "system",
      "content": "Analyze this retail support ticket and return ONLY valid JSON. Use exactly these fields: category, priority, response. Allowed categories: INVENTORY, TECH, MACHINERY, CUSTOMER_ORDER, FACILITIES, PAYMENT, OTHER. Allowed priorities: LOW, MEDIUM, HIGH, CRITICAL. Example response: {\\"category\\":\\"FACILITIES\\",\\"priority\\":\\"CRITICAL\\",\\"response\\":\\"The reported issue appears to be a critical facilities problem and the electric repair main will be notified.\\"}"
    },
    {
      "role": "user",
      "content": "%s"
    }
  ]
}
""".formatted(
    model,
    escapeJson(ticket.getDescription())
);
            HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(apiUrl))
                .header("Content-Type", "application/json")
                .header("X-api-key", apiKey)
                .POST(
                    HttpRequest.BodyPublishers.ofString(requestBody)
                )
                .build();

            HttpResponse<String> response = httpClient.send(
                request,
                HttpResponse.BodyHandlers.ofString()
            );

            System.out.println(
                "AI STATUS: " + response.statusCode()
            );

            System.out.println("AI RESPONSE: " + response.body());

ObjectMapper objectMapper = new ObjectMapper();

JsonNode root = objectMapper.readTree(response.body());

String content = root
    .path("choices")
    .get(0)
    .path("message")
    .path("content")
    .asString()
    .trim();
   

    
    System.out.println("AI CONTENT " + content);

    JsonNode analysis = objectMapper.readTree(content);

  String category = analysis
                .path("category")
                .asString()
                .trim()
                .toUpperCase();

            String priority = analysis
                .path("priority")
                .asString()
                .trim()
                .toUpperCase();

            String aiResponse = analysis
                .path("response")
                .asString()
                .trim();

            ticket.setCategory(category);
            ticket.setPriority(priority);
            ticket.setAiResponse(aiResponse);

            System.out.println("CATEGORY: " + category);

            System.out.println("PRIORITY: " + priority);

            System.out.println("AI DRAFT RESPONSE: " + aiResponse);

            return ticket;

        } catch (Exception e) {

            e.printStackTrace();

            ticket.setCategory("OTHER");
            ticket.setPriority("MEDIUM");
            ticket.setAiResponse("AI analysis could not be completed.");

            return ticket;
        }
    }

    private String escapeJson(String text) {
        return text
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\n", "\\n")
            .replace("\r", "\\r");
    }
}