package com.bookland.demobookland.model;


import lombok.Data;

import javax.persistence.*;
import java.text.DateFormat;

@Entity
@Data
@Table(name = "customer")
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CustomerId", nullable = false)
    private int customerId;

    @Column(name = "Name", nullable = false)
    private String firstName;

    @Column(name = "Surname", nullable = false)
    private String surname;

    @Column(name = "Username", nullable = false)
    private String email;

    @Column(name = "Password", nullable = false)
    private String password;

    @Column(name = "DateOfBirth")
    private DateFormat dateOfBirth;

    @Column(name = "PhoneNumber")
    private String phoneNumber;


}
