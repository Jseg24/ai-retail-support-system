package com.example.retail_support.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "tickets")
public class Ticket {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;

@Column(name = "associate_id")
private String associateId;

@Column(name = "associate_name")
private String associateName;

@Column(name = "associate_email")
private String associateEmail;

@Column(name = "store_number")
private String storeNumber;

@Column(columnDefinition = "TEXT")
private String description;


private String category;

private String priority;

private String status;

@Column(name = "ai_response", columnDefinition = "TEXT")
private String aiResponse;

public Ticket(){
}

public Long getId(){
    return id;
}
public String getAssociateId(){
    return associateId;
}
public void setAssociateId(String associateId){
    this.associateId = associateId;
}
public String getAssociateName(){
    return associateName;
}

public void setAssociateName(String associateName){
this.associateName = associateName;
}

public String getAssociateEmail(){
    return associateEmail;
}

public void setAssociateEmail(String associateEmail){
this.associateEmail = associateEmail;
}
public String getStoreNumber(){
    return storeNumber;
}
public void setStoreNumber(String storeNumber){
    this.storeNumber = storeNumber;
}
public String getDescription(){
    return description;
}
public void setDescription(String description){
this.description = description;
}
public String getCategory(){
    return category;
}
public void setCategory(String category){
    this.category = category;
}
public String getPriority(){
    return priority;
}
public void setPriority(String priority){
    this.priority = priority;
}
public String getStatus(){
    return status;
}
public void setStatus(String status){
    this.status = status;
}
public String getAiResponse(){
    return aiResponse;
}
public void setAiResponse(String aiResponse){
    this.aiResponse = aiResponse;
}
 
}
