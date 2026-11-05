package com.example.retail_support.controller;

import com.example.retail_support.model.Ticket;
import com.example.retail_support.service.TicketService;

import java.util.List;

import org.springframework.web.bind.annotation.*;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/api/tickets")
@CrossOrigin(origins = "*")
public class TicketController {

    @Value("${app.demo-read-only:false}")
    private boolean demoReadOnly;

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
    requireWritableDemo();
    return ticketService.approveTicket(id);
}
@PatchMapping ("/{id}/reject")
public Ticket rejectTicket(@PathVariable Long id){
    requireWritableDemo();
    return ticketService.rejectTicket(id);
}
@DeleteMapping("/{id}/delete")
  public Ticket deleteTicket(@PathVariable Long id){
    requireWritableDemo();
    return ticketService.deleteTicket(id);
  }
  private void requireWritableDemo(){
    if(demoReadOnly){
        throw new ResponseStatusException(
            HttpStatus.FORBIDDEN,
            "Administrative actions are disabled in the public demo."
        );
    }
}
}