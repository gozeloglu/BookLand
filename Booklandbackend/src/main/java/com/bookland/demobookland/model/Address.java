package com.bookland.demobookland.model;

import com.bookland.demobookland.model.validationGroups.AddAddressGroup;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.GroupSequence;
import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "address")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})

/*Json objects are necessary for avoiding infinite recursion*/
@GroupSequence({Address.class, AddAddressGroup.class})
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AddressId", nullable = false)
    private int addressId;

    @Column(name = "AddressLine", nullable = false)
    @NotBlank(message = "Address line cannot be empty", groups = AddAddressGroup.class)
    @Length(min = 8, max = 255, message = "Give a valid Address Information", groups = AddAddressGroup.class)
    private String addressLine;

    @Column(name = "AddressTitle", nullable = false)
    @NotBlank(message = "Give an address title", groups = AddAddressGroup.class)
    private String addressTitle;

    /*Merge updates if the postal code exist.For example if we have a record in database like 06530-Ankara
     * and if we call saveAddress with parameters 06530-Istanbul it will update as 06530-Istanbul in database
     * in real life for a city postal codes are unique so there cannot be situation like this so that's why it does
     * not create a problem*/

    //@JsonManagedReference
    @Valid
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.MERGE)
    @JoinColumn(name = "postalCode")
    private PostalCodeCity postalCodeCity;

    @JsonBackReference(value = "address-customerOrderList") /*myAddresses i çağırdığında o adrese ait orderların gözükmesini istersen jsonbackreference kaldır*/
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "address")
    private List<Order> customerOrdersList;

    @JsonBackReference(value = "address-customerList")
    @ManyToMany(mappedBy = "customerAddressList")
    private List<Customer> customerList = new ArrayList<>();
}
