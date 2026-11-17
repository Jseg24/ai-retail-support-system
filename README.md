Retail Support System

A simple AI powered retail support application that allows store associates to submit tickets and automatically classifies them using an external AI service.
The project was inspired by retail support workflows I have encountered in a store enviornment.

*This independent project does not use any proprietary company information*

How It Works:
1. A user submits a support ticket.
2. The Spring Boot backend receives the request.
3. The ticket is processed by an external AI service.
4. The AI assigns a category, priority, and suggested response.
5. The processed ticket is stored in Cloud SQL.
6. The review page displays the result for manual administrative review.

Tech Stack:

Frontend: Flutter, Firebase Hosting

Backend: Java, SpringBoot, Spring Data JPA, Maven, Docker

Cloud: Google Cloud Run, Google Cloud SQL, Google Artifact Registry, Google Secret Manager, Firebase Hosting

Database: MySQL

AI: DeepSeek V4

Public Demo:
*Administrative privileges are limited in the pulbic demo*

Ticket Form:
https://retail-support-project-511613.web.app/

Administrative Review Page:
https://retail-support-project-511613.web.app/#/admin

*Demo note: The admin page may be slow to load initially as the cloud backend starts up.*


