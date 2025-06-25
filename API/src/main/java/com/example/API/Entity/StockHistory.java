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
public class StockHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer stockID;

    @ManyToOne
    @JoinColumn(name = "variantID")
    private ProductVariant variant;

    @ManyToOne
    @JoinColumn(name = "importID")
    private ProductImport importEntry;

    private Integer quantity;

    @Enumerated(EnumType.STRING)
    private StockType type;

    private LocalDateTime createdAt = LocalDateTime.now();
}
