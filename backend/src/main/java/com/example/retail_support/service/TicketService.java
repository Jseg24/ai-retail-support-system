package com.example.retail_support.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.retail_support.model.Ticket;
import com.example.retail_support.repository.TicketRepository;


@Service
public class TicketService {
    
private final TicketRepository ticketRepository;
private final AIService aiService;

public TicketService(
    TicketRepository ticketRepository,
    AIService aiService
) {
    this.ticketRepository = ticketRepository;
    this.aiService = aiService;
}


    public Ticket createTicket(Ticket ticket){
        ticket.setStatus("OPEN");
    String category = aiService.classifyTicket(ticket.getDescription());

    ticket.setCategory(category);

      
        return ticketRepository.save(ticket);
    }


   public List<Ticket> findAll() {
        return ticketRepository.findAll();
    }
}