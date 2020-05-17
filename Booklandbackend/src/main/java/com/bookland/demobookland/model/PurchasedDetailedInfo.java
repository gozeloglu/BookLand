package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "purchaseddetailedinfo")
public class PurchasedDetailedInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "TrackingNumber")
    private Integer trackingNumber;

    @Column(name = "ShippingCompanyId")
    private Integer shippingCompanyId;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DeliveryTime", columnDefinition = "TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss.SS")
    private Date releasedTime = new Date();

    @Column(name = "Status")
    private String status = "Waiting Confirmation";

    @JsonBackReference(value = "shippingCompany")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "ShippingCompanyId", insertable = false, updatable = false)
    private ShippingCompany shippingCompany;

    @JsonBackReference(value = "contains")
    @OneToOne(fetch = FetchType.LAZY,
            cascade = CascadeType.ALL,
            mappedBy = "purchasedDetailedInfo")
    private Contains contains;

}
