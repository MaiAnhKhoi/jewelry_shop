package com.example.API.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "Addresses")
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer addressID;

    @ManyToOne
    @JoinColumn(name = "userID")
    private User user;

    private String receiverName;
    private String phone;
    private String province;
    private String district;
    private String ward;
    private String fullAddress;
    private String landmark;
    private String imageURL;
    private Boolean isDefault;
}

//huy