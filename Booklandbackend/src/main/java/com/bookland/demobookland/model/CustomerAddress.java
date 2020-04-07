package com.bookland.demobookland.model;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "customeraddress")
@Data
@IdClass(CustomerAddressPk.class)
public class CustomerAddress {

    @Id
    @Column(name = "CustomerId")
    private int customerId;

    @Id
    @Column(name = "AddressId")
    private int addressId;

    @ManyToOne(fetch = FetchType.LAZY,cascade= CascadeType.ALL)
    @JoinColumn(name = "CustomerId")
    private Customer customer;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "addressId",referencedColumnName = "addressId")
    private Address address;

}
