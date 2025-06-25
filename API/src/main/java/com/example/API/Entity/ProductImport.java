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
public class ProductImport {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer importID;

    @ManyToOne
    @JoinColumn(name = "supplierID")
    private Supplier supplier;

    private LocalDateTime importedAt = LocalDateTime.now();

    @Column(columnDefinition = "TEXT")
    private String note;
}