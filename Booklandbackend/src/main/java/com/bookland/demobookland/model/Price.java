package com.bookland.demobookland.model;


import com.bookland.demobookland.model.validationGroups.AddBookGroup;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import javax.validation.GroupSequence;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler", "releasedTime"})
@Entity
@Table(name = "price")
@GroupSequence({Price.class, AddBookGroup.class})
public class Price {

    @Column(name = "ISBN", nullable = false)
    private int ISBN;

    @Id
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DateTime", columnDefinition = "TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private Date releasedTime = new Date();


    @Column(name = "price", nullable = false)
    @NotNull(message = "Price field cannot be empty", groups = AddBookGroup.class)
    @Min(value = 0, message = "Price cannot be lower than zero", groups = AddBookGroup.class)
    private Float price;


    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "ISBN", insertable = false, updatable = false)
    private Book bookPrices;

}
