package com.bookland.demobookland.model;

import lombok.Data;

import javax.persistence.*;
import java.text.DateFormat;

@Entity
@Data
@Table(name = "customer")
public class Admin {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CustomerId", nullable = false)
    private int adminId;

    @Column(name = "Username", nullable = false)
    private String email;

    @Column(name = "Password", nullable = false)
    private String password;

}









