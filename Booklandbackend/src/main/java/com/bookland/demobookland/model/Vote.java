package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "vote")
@IdClass(VotePk.class)
public class Vote {

    @Id
    @Column(name = "CustomerId")
    private Integer customerId;

    @Id
    @Column(name = "ISBN")
    private Integer isbn;

    @Column(name = "VoteNumber")
    private Integer voteNumber;

    @JsonBackReference(value = "vote-customer")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "customerId", insertable = false, updatable = false)
    private Customer customerVote;

    @JsonBackReference(value = "vote-book")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "ISBN", insertable = false, updatable = false)
    private Book bookVote;

}
