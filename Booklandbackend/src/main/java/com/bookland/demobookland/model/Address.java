package com.bookland.demobookland.model;

import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
@Data
@Table(name = "address")
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AddressId", nullable = false,updatable = false)
    private int addressId;

    @Column(name = "AddressLine", nullable = false)
    @NotBlank(message = "AddressLine is Necessary")
    @Size(min = 8, max = 255, message = "Give a valid Address Information")
    private String addressLine;

    @Column(name = "AddressTitle", nullable = false)
    @NotBlank(message = "Address Title is Necessary")
    private String addressTitle;

    /*Merge updates if the postal code exist.For example if we have a record in database like 06530-Ankara
    * and if we call saveAddress with parameters 06530-Istanbul it will update as 06530-Istanbul in database
    * in real life for a city postal codes are unique so there cannot be situation like this so that's why it does
    * not create a problem*/

    @ManyToOne(fetch = FetchType.LAZY,cascade= CascadeType.MERGE)
    @JoinColumn(name = "postalCode")
    private PostalCodeCity postalCodeCity;

    @OneToOne(mappedBy = "address")  /*Mapped by name is corresponds to relation on the other entity*/
    private CustomerAddress customerAddress;
}
