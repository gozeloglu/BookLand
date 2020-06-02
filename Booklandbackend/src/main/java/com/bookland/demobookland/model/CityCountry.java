package com.bookland.demobookland.model;


import com.bookland.demobookland.model.validationGroups.AddAddressGroup;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import javax.validation.GroupSequence;
import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "city_country")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@GroupSequence({CityCountry.class, AddAddressGroup.class})
public class CityCountry {

    @Id
    @Column(name = "City", nullable = false)
    @NotBlank(message = "City cannot be empty", groups = AddAddressGroup.class)
    private String city;

    @Column(name = "Country", nullable = false)
    @NotBlank(message = "Country cannot be empty", groups = AddAddressGroup.class)
    private String country;

    @JsonBackReference
    @OneToMany(fetch = FetchType.LAZY,
            mappedBy = "city")
    private List<PostalCodeCity> postalCodeCities = new ArrayList<>();

}
