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
    ticket = aiService.analyzeTicket(ticket);
ticket.setStatus("PENDING_REVIEW");
  
        return ticketRepository.save(ticket);
    }


    //Only works because its a small dataset. Imagine 500 or 5000 entries. 
    //Can use: pagination, filtering, sorting, search, date ranges, status, and filters to be more effective.
   public List<Ticket> findAll() {
        return ticketRepository.findAll();
    }
    

public Ticket approveTicket(Long id){
    Ticket ticket = ticketRepository
            .findById(id)
            .orElseThrow();
            ticket.setStatus("APPROVED");
            return ticketRepository.save(ticket);
}
public Ticket rejectTicket(Long id){
    Ticket ticket = ticketRepository
            .findById(id)
            .orElseThrow();
            ticket.setStatus("REJECTED");
            return ticketRepository.save(ticket);
}


public Ticket deleteTicket(Long id) {
    Ticket ticket = ticketRepository.findById(id).orElseThrow();

    ticketRepository.deleteById(id);

    return ticket;
}
}