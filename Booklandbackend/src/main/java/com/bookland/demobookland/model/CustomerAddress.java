package com.bookland.demobookland.model;

import com.bookland.demobookland.model.validationGroups.AddAddressGroup;
import com.bookland.demobookland.model.validationGroups.AddBookGroup;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import javax.validation.GroupSequence;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

@Data

@Entity
@Table(name = "customeraddress")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@GroupSequence({CustomerAddress.class, AddAddressGroup.class})
public class CustomerAddress{

    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AddressId")
    private int addressId;

    @Column(name = "CustomerId")
    private int customerId;

    //@JsonManagedReference
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "CustomerId", insertable = false, updatable = false)           /*Database column ismi*/
    private Customer customer;

    //@JsonManagedReference
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)/*all*/
    @JoinColumn(name = "AddressId") /*Mapped by name is corresponds to relation on the other entity*/
    @NotNull(message = "Address", groups = AddBookGroup.class)
    private Address address;


}
