package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@Table(name = "search")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler", "releasedTime"})
public class Search {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SearchId")
    private Integer searchId;

    @Column(name = "CustomerId")
    private Integer customerId;

    @Column(name = "SearchedWord")
    private String searchedWord;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "SearchTime", columnDefinition = "TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss.SS")
    private Date releasedTime = new Date();

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "CustomerId", insertable = false, updatable = false)
    private Customer customer;
}
