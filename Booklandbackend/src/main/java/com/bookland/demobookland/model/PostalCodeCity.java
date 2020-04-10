package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
@Table(name = "postalcode_city")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})

/*Json objects are necessary for avoiding infinite recursion*/

public class PostalCodeCity {

    @Id
    @Column(name = "PostalCode", nullable = false)
    private String postalCode;

    //@JsonManagedReference
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.MERGE)
    @JoinColumn(name = "city")
    private CityCountry city;

    /*For result set and the relationship*/
    @JsonBackReference
    @OneToMany(fetch = FetchType.LAZY
            , mappedBy = "postalCodeCity")
    private List<Address> addressList;


}
