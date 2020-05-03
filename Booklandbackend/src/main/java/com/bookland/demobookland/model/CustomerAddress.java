package com.bookland.demobookland.model;

import com.bookland.demobookland.model.validationGroups.AddAddressGroup;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import javax.validation.GroupSequence;
import javax.validation.constraints.NotNull;

@Data

@Entity
@Table(name = "customeraddress")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@GroupSequence({CustomerAddress.class, AddAddressGroup.class})
public class CustomerAddress {

    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AddressId")
    private int addressId;

    @Column(name = "CustomerId")
    private int customerId;

    //@JsonManagedReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CustomerId", insertable = false, updatable = false)           /*Database column ismi*/
    private Customer customer;

    //@JsonManagedReference
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)/*adres tablosundan adresi de siliyo eğer istemezsen cascade type ı kaldır*/
    @JoinColumn(name = "AddressId") /*Mapped by name is corresponds to relation on the other entity*/
    @NotNull(message = "Address")
    private Address address;


}
