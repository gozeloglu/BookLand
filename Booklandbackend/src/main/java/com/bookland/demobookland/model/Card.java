package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Data
@Table(name = "card")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Card {

    @Id
    @Column(name = "CardNo", nullable = false)
    private String postalCode;

    @Column(name = "OwnerName", nullable = false)
    private String ownerName;

    @Column(name = "OwnerSurname", nullable = false)
    private String ownerSurname;

}
