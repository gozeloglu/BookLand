package com.bookland.demobookland.model;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.Date;

@Entity
@Data
@Table(name = "customer")
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CustomerId", nullable = false)
    private int customerId;

    @Column(name = "Name", nullable = false)
    @NotBlank(message = "Name is Necessary")
    private String firstName;

    @Column(name = "Surname", nullable = false)
    @NotBlank(message = "Surname is Necessary")
    private String surname;

    @Column(name = "Username", nullable = false)
    @Email(message = "Email must be a valid email address")
    @NotBlank(message = "Username is Necessary")
    private String email;

    @Column(name = "Password", nullable = false)
    @NotBlank(message = "Password is Necessary")
    @Size(min = 8,message = "Your password must be at least 8 characters")
    private String password;

    @JsonFormat(pattern="yyyy-MM-dd")
    @Column(name = "DateOfBirth")
    private Date dateOfBirth;

    @Column(name = "PhoneNumber")
    private String phoneNumber;

}
