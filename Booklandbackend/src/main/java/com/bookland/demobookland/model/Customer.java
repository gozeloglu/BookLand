package com.bookland.demobookland.model;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;
import java.util.Date;
import java.util.List;

@Entity
@Data
@Table(name = "customer")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CustomerId")
    private int customerId;

    @Column(name = "Name")
    //@NotBlank(message = "Name is Necessary")
    private String firstName;

    @Column(name = "Surname")
    //@NotBlank(message = "Surname is Necessary")
    private String surname;

    @Column(name = "Username")
    @Email(message = "Email must be a valid email address")
    // @NotBlank(message = "Username is Necessary")
    private String email;

    @Column(name = "Password")
    //@NotBlank(message = "Password is Necessary")
    @Size(min = 8, message = "Your password must be at least 8 characters")
    private String password;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @Column(name = "DateOfBirth")
    private Date dateOfBirth;

    @Column(name = "PhoneNumber")
    private String phoneNumber;


    /*CustomerAddress de ki bu ilişkiye karşı gelen ilişkinin variable name'i yazılıyo*/
    @JsonBackReference /*Eğer customerı çektiğim zaman adreslerininde gelmesini istersem jsonback i customeraddresse yazcan*/
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "customer")
    private List<CustomerAddress> customerAddressList;

}
