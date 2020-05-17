package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "contains")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@IdClass(ContainsPk.class)
public class Contains {

    @Id
    @Column(name = "OrderId")
    private Integer orderId;

    @Id
    @Column(name = "ISBN")
    private Integer isbn;

    @Id
    @Column(name = "TrackingNumber")
    private Integer trackingNumber;

    @Column(name = "Quantity")
    private Integer quantity;

    @Column(name = "Status")
    private Integer status;

    /*Database column ismi*/
    @JsonBackReference(value = "contains-orders")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "OrderId", insertable = false, updatable = false)
    private Order orders;

    @JsonBackReference(value = "contains-book")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "ISBN", insertable = false, updatable = false)           /*Database column ismi*/
    private Book book;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "trackingNumber", insertable = false, updatable = false)
    private PurchasedDetailedInfo purchasedDetailedInfo;
}
