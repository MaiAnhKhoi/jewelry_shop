package com.example.API.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SystemConfig {
    @Id
    @Column(length = 50)
    private String configKey;

    @Column(length = 255)
    private String configValue;
}