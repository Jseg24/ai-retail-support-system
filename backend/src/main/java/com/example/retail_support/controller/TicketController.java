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
@PatchMapping("/{id}/approve")
public Ticket approveTicket(@PathVariable Long id){
    return ticketService.approveTicket(id);
}
@PatchMapping ("/{id}/reject")
public Ticket rejectTicket(@PathVariable Long id){
    return ticketService.rejectTicket(id);
}
@DeleteMapping("/{id}/delete")
  public Ticket deleteTicket(@PathVariable Long id){
    return ticketService.deleteTicket(id);
  }
}