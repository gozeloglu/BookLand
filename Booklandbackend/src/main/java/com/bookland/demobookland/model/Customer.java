package com.bookland.demobookland.model;


import com.bookland.demobookland.model.validationGroups.AddBookGroup;
import com.bookland.demobookland.model.validationGroups.LoginGroup;
import com.bookland.demobookland.model.validationGroups.SignUpGroup;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import javax.validation.GroupSequence;
import javax.validation.Valid;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Data
@Table(name = "customer")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@GroupSequence({Customer.class, LoginGroup.class, SignUpGroup.class})
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CustomerId")
    private int customerId;

    @Column(name = "Name")
    @NotBlank(message = "Name is Necessary", groups = SignUpGroup.class)
    private String firstName;

    @Column(name = "Surname")
    @NotBlank(message = "Surname is Necessary", groups = SignUpGroup.class)
    private String surname;

    @Column(name = "Username")
    @Email(message = "Email must be a valid email address", groups = {SignUpGroup.class, LoginGroup.class})
    @NotBlank(message = "Email is Necessary", groups = {SignUpGroup.class, LoginGroup.class})
    private String email;

    @Column(name = "Password")
    @NotBlank(message = "Password is Necessary", groups = {SignUpGroup.class, LoginGroup.class})
    @Size(min = 8, message = "Your password must be at least 8 characters", groups = {SignUpGroup.class, LoginGroup.class})
    private String password;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @Column(name = "DateOfBirth")
    private Date dateOfBirth;

    @Column(name = "PhoneNumber")
    private String phoneNumber;

    @Column(name = "IsAdmin")
    private Integer isAdmin = 0;

    @JsonBackReference(value = "customer-OrdersList")
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "customer", orphanRemoval = true)
    private List<Order> customerOrdersList= new ArrayList<>();

    @JsonBackReference(value = "customer-SearchList")
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "customer", orphanRemoval = true)
    private List<Search> customerSearchList;

    //@JsonBackReference(value = "customer-commentList")
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "customerComment")
    private List<Comment> commentList;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "card_used_by",
            joinColumns = {@JoinColumn(name = "CustomerId")},
            inverseJoinColumns = {@JoinColumn(name = "CardNo")})
    private List<Card> customerCardList = new ArrayList<>();

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "customeraddress",
            joinColumns = {@JoinColumn(name = "CustomerId")},
            inverseJoinColumns = {@JoinColumn(name = "addressid")})
    private List<Address> customerAddressList = new ArrayList<>();
}
