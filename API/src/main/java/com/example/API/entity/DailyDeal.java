package com.example.API.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "DailyDeals")
public class DailyDeal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer dealID;

    @ManyToOne
    @JoinColumn(name = "productID")
    private Product product;

    @ManyToOne
    @JoinColumn(name = "variantID")
    private ProductVariant variant;

    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    private Double discountPercent;

    private Integer minQuantity;

    private Boolean isActive = true;

    private LocalDate startDate;

    private LocalDate endDate;

    private LocalDateTime createdAt = LocalDateTime.now();
}
