package com.example.API.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "ProductVariants")
public class ProductVariant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer variantID;

    private String color;
    private String size;
    private Double price;
    private Integer stock;

    @ManyToOne
    @JoinColumn(name = "productID")
    private Product product;
}

//huy