package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
@Data
@Table(name = "address")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})

/*Json objects are necessary for avoiding infinite recursion*/

public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AddressId", nullable = false)
    private int addressId;

    @Column(name = "AddressLine", nullable = false)
    @NotBlank(message = "AddressLine is Necessary")
    @Size(max = 255, message = "Give a valid Address Information")
    private String addressLine;

    @Column(name = "AddressTitle", nullable = false)
    @NotBlank(message = "Address Title is Necessary")
    private String addressTitle;

    /*Merge updates if the postal code exist.For example if we have a record in database like 06530-Ankara
     * and if we call saveAddress with parameters 06530-Istanbul it will update as 06530-Istanbul in database
     * in real life for a city postal codes are unique so there cannot be situation like this so that's why it does
     * not create a problem*/

    //@JsonManagedReference
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.MERGE)
    @JoinColumn(name = "postalCode")
    private PostalCodeCity postalCodeCity;

    @JsonBackReference
    @OneToOne(fetch = FetchType.LAZY, mappedBy = "address")
    private CustomerAddress customerAddress;

}
