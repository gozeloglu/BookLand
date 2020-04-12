package com.bookland.demobookland.model;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Entity
@Table(name = "price")
public class Price {

    @Column(name = "ISBN", nullable = false)
    private int ISBN;

    @Id
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DateTime", columnDefinition = "TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private Date releasedTime=new Date();


    @Column(name = "price", nullable = false)
    private Float price;


    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "ISBN", insertable = false, updatable = false)           /*Database column name*/
    private Book bookPrices;

}
