package com.bookland.demobookland.model;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
@Table(name = "postalcode_city")
public class PostalCodeCity {

    @Id
    @Column(name = "PostalCode", nullable = false)
    private String postalCode;

    @ManyToOne(fetch = FetchType.LAZY,cascade=CascadeType.MERGE)
    @JoinColumn(name = "city")
    private CityCountry city;

    /*For result set and the relationship*/
    @OneToMany(fetch = FetchType.LAZY
            , mappedBy = "postalCodeCity")
    private List<Address> addressList;


}
