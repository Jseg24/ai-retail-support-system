package com.example.retail_support.repository;

import com.example.retail_support.model.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
//gives methods like save(tickets) findAll(), findById(id), deleteById(id)
public interface TicketRepository extends JpaRepository<Ticket, Long> {
    
}
