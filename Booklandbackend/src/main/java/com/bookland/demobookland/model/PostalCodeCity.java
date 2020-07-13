package com.bookland.demobookland.model;

import com.bookland.demobookland.model.validationGroups.AddAddressGroup;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import javax.validation.GroupSequence;
import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

@Entity
@Data
@Table(name = "postalcode_city")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})

/*Json objects are necessary for avoiding infinite recursion*/
@GroupSequence({PostalCodeCity.class, AddAddressGroup.class})
public class PostalCodeCity {

    @Id
    @Column(name = "PostalCode", nullable = false)
    @NotBlank(message = "PostalCode cannot be empty", groups = AddAddressGroup.class)
    private String postalCode;

    @Valid
    @NotNull(message = "City cannot be empty", groups = AddAddressGroup.class)
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.MERGE)
    @JoinColumn(name = "city")
    private CityCountry city;

    @JsonBackReference
    @OneToMany(fetch = FetchType.LAZY
            , mappedBy = "postalCodeCity")
    private List<Address> addressList;


}
