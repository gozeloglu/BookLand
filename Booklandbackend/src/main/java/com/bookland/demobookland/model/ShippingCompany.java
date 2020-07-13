package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;

/*Relations gonna be add*/
@Entity
@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "shippingcompany")
public class ShippingCompany {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ShippingCompanyId", nullable = false)
    private Integer shippingCompanyId;

    @Column(name = "Price", nullable = false)
    private Float shippingPrice;

    @Column(name = "Website", nullable = false)
    private String website;

    @Column(name = "CompanyName", nullable = false)
    private String companyName;
}
