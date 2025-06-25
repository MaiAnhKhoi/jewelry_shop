package com.example.API.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Conversation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer conversationID;

    @ManyToOne
    @JoinColumn(name = "userID")
    private User user;

    private LocalDateTime createdAt = LocalDateTime.now();
}
