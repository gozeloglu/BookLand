package com.bookland.demobookland.model;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Entity
@Table(name = "price")
public class Price {

    @Id
    @Column(name = "ISBN", nullable = false)
    private int ISBN;

    @Column(name = "price", nullable = false)
    private int price;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "DateTime", nullable = false)
    private Date releasedTime;

}
