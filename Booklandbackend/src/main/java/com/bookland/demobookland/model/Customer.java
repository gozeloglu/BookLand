package com.bookland.demobookland.model;


import com.bookland.demobookland.model.validationGroups.LoginGroup;
import com.bookland.demobookland.model.validationGroups.SignUpGroup;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import javax.validation.GroupSequence;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
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

    /*CustomerAddress de ki bu ilişkiye karşı gelen ilişkinin variable name'i yazılıyo*/
    @JsonBackReference(value = "customer-AddressList") /*Eğer customerı çektiğim zaman adreslerininde gelmesini istersem jsonback i customeraddresse yazcan*/
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "customer")
    private List<CustomerAddress> customerAddressList;

    @JsonBackReference(value = "customer-OrdersList")
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "customer")
    private List<Order> customerOrdersList;
}
