package com.example.API.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductVariant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer variantID;

    @ManyToOne
    @JoinColumn(name = "productID")
    private Product product;

    @Column(length = 50)
    private String color;

    @Column(length = 50)
    private String size;

    private BigDecimal price;

    private Integer stock = 0;
}
