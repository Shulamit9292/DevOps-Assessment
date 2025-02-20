package com.example


import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.stereotype.Service
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import org.springframework.data.jpa.repository.JpaRepository
import javax.persistence.*

// Main class for Spring Boot application
@SpringBootApplication
class App {
    static void main(String[] args) {
        SpringApplication.run(App, args)
    }
}

// Entity class representing the counter in the database
@Entity
class Counter {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-generate IDs
    Long id
    int hits // Counter to track hits
}

// Repository interface to interact with the database
interface CounterRepository extends JpaRepository<Counter, Long> {}

// Service class responsible for managing the counter logic
@Service
class CounterService {
    @Autowired
    CounterRepository counterRepository // Injecting the repository

    // Method to increment the counter value
    void incrementCounter() {
        Counter counter = counterRepository.findById(1L).orElse(new Counter()) // Fetch counter or create new
        counter.hits += 1 // Increase the counter
        counterRepository.save(counter) // Save to DB
    }
}

// Controller class to handle HTTP requests
@RestController
class CounterController {
    @Autowired
    CounterService counterService // Injecting the counter service

    // Endpoint to return a basic "Hello World" HTML page
    @GetMapping("/")
    String helloWorld() {
        return "<h1>Hello World from Docker and Ansible!</h1>" // Simple HTML page
    }

    // Endpoint to increment the counter
    @PostMapping("/hit")
    String incrementCounter() {
        counterService.incrementCounter() // Call service to update counter
        return "Counter updated" // Return success message
    }
}
