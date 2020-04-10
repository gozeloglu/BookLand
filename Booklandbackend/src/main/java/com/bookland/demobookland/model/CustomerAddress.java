package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data

@Entity
@Table(name = "customeraddress")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})

public class CustomerAddress{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AddressId")
    private int addressId;

    @Column(name = "CustomerId")
    private int customerId;

    //@JsonManagedReference
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "CustomerId", insertable = false, updatable = false)           /*Database column ismi*/
    private Customer customer;

    //@JsonManagedReference
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.MERGE)
    @JoinColumn(name = "AddressId") /*Mapped by name is corresponds to relation on the other entity*/
    private Address address;


}
