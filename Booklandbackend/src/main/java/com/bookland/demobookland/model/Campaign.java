package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Entity
@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "campaign")
public class Campaign {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CampaignId", nullable = false)
    private Integer campaignId;

    @Column(name = "CouponCode", nullable = false)
    @Length(min = 8,max = 16,message = "Coupon code must be valid")
    private String couponCode;

    @Column(name = "CouponDiscount", nullable = false)
    @NotNull(message = "Coupon discount field cannot be empty")
    private Integer couponDiscount;

    @Column(name = "ParticipantQuantity", nullable = false)
    @NotNull(message = "Enter how many coupon is available to use")
    private Integer participantQuantity;

    @Column(name = "CampaignName", nullable = false)
    @NotBlank(message = "Campaign name field cannot be empty")
    private String campaignName;

    @Temporal(TemporalType.DATE)
    @NotNull(message = "Give a valid end date for campaign")
    @Column(name = "EndDate", nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

    @JsonBackReference
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "campaign")
    private List<Order> orderCampaignList;
}
