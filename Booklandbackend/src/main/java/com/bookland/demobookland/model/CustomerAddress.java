package com.bookland.demobookland.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data

@Entity
@Table(name = "customeraddress")
public class CustomerAddress implements Serializable {

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
