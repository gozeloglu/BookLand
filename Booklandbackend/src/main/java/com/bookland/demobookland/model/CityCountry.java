package com.bookland.demobookland.model;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.ToString;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "city_country")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class CityCountry {

    @Id
    @Column(name = "City", nullable = false)
    private String city;

    @Column(name = "Country", nullable = false)
    @NotBlank(message = "Country Information is Necessary")
    private String country;

    @JsonBackReference
    @OneToMany(fetch = FetchType.LAZY,
            mappedBy = "city")
            //orphanRemoval = true)
    private List<PostalCodeCity> postalCodeCities = new ArrayList<>();

}
