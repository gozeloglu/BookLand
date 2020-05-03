package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "order")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderId", nullable = false)
    private Integer orderId;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DateTime", columnDefinition = "TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private Date orderedTime=new Date();

    @Column(name = "CardNo", nullable = false)
    private String cardNo;

    @Column(name = "CustomerId", nullable = false)
    private Integer customerId;

    @Column(name = "AddressId", nullable = false)
    private Integer addressId;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "CustomerId", insertable = false, updatable = false)           /*Database column ismi*/
    private Customer customer;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "AddressId", insertable = false, updatable = false)           /*Database column ismi*/
    private Address address;
}
