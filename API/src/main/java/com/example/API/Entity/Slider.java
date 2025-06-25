package com.example.API.Entity;

import jakarta.persistence.*;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Slider {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer sliderID;

    @Column(length = 100)
    private String title;

    @Column(length = 255)
    private String imageURL;

    @Column(length = 255)
    private String linkURL;

    private Integer displayOrder = 0;

    private Boolean isActive = true;
}