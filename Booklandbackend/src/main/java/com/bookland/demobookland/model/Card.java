package com.bookland.demobookland.model;

import com.bookland.demobookland.model.validationGroups.LoginGroup;
import com.bookland.demobookland.model.validationGroups.SaveCardGroup;
import com.bookland.demobookland.model.validationGroups.SignUpGroup;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.GroupSequence;
import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@Table(name = "card")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@GroupSequence({Card.class, SaveCardGroup.class})
public class Card {

    @Id
    @NotBlank(message = "Card Number cannot be empty",groups = SaveCardGroup.class)
    @Length(min = 16,max = 16,message = "Card Number must be 16 digit number",groups = SaveCardGroup.class)
    @Column(name = "CardNo", nullable = false)
    private String cardNo;

    @Column(name = "OwnerName", nullable = false)
    @NotBlank(message = "Owner Name cannot be empty",groups = SaveCardGroup.class)
    private String ownerName;

    @Column(name = "OwnerSurname", nullable = false)
    @NotBlank(message = "Owner Surname cannot be empty",groups = SaveCardGroup.class)
    private String ownerSurname;

    @JsonBackReference
    @ManyToMany(mappedBy = "customerCardList")
    private List<Customer> customerList=new ArrayList<>();
}
