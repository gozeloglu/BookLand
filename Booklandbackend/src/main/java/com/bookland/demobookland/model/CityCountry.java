package com.bookland.demobookland.model;


import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "city_country")
public class CityCountry {

    @Id
    @Column(name = "City", nullable = false)
    private String city;

    @Column(name = "Country", nullable = false)
    @NotBlank(message = "Country Information is Necessary")
    private String country;

    @OneToMany(fetch = FetchType.LAZY,
            mappedBy = "city")
            //orphanRemoval = true)
    private List<PostalCodeCity> postalCodeCities = new ArrayList<>();

}
