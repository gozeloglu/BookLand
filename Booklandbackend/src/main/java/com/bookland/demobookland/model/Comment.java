package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@Table(name = "comment")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler", "commentTime"})
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CommentId")
    private Integer commentId;

    @Column(name = "ISBN")
    private Integer bookId;

    @Column(name = "customerId")
    private Integer customerId;

    @Column(name = "CommentText")
    private String commentText;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "CommentTime", columnDefinition = "TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss.SS")
    private Date commentTime = new Date();

    @JsonBackReference(value = "customer-comment")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "customerId", insertable = false, updatable = false)
    private Customer customerComment;

    @JsonBackReference(value = "book-comment")
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "ISBN", insertable = false, updatable = false)           /*Database column name*/
    private Book bookComment;
}
