package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "card")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Card {

    @Id
    @Column(name = "CardNo", nullable = false)
    private String cardNo;

    @Column(name = "OwnerName", nullable = false)
    private String ownerName;

    @Column(name = "OwnerSurname", nullable = false)
    private String ownerSurname;

    @JsonBackReference
    @ManyToMany(mappedBy = "customerCardList")
    private List<Customer> customerList=new ArrayList<>();
}
