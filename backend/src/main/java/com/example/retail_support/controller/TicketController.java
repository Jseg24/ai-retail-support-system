package com.example.retail_support.controller;

import com.example.retail_support.model.Ticket;
import com.example.retail_support.service.TicketService;

import java.util.List;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/tickets")
@CrossOrigin(origins = "*")
public class TicketController {

    private final TicketService ticketService;

    public TicketController(TicketService ticketService) {
        this.ticketService = ticketService;
    }

    @PostMapping
    public Ticket createTicket(@RequestBody Ticket ticket) {
        return ticketService.createTicket(ticket);
    }
    @GetMapping
public List<Ticket> getAllTickets() {
    return ticketService.findAll();
}
}