package com.example.API.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer addressID;

    @ManyToOne
    @JoinColumn(name = "userID")
    private User user;

    @Column(length = 100)
    private String receiverName;

    @Column(length = 20)
    private String phone;

    @Column(length = 255)
    private String fullAddress;

    private Boolean isDefault = false;
}