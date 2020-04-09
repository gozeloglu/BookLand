package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "book")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ISBN", nullable = false)
    private Integer bookId;

    @Column(name = "BookName", nullable = false)
    private String bookName;

    @Column(name = "Author", nullable = false)
    private String author;

    @Column(name = "Description")
    private String description;

    @Column(name = "Category", nullable = false)
    private String category;

    @Column(name = "SubCategory")
    private String subCategory;

    @Column(name = "InHotList")
    private Integer inHotList;

    @Column(name = "Status")
    private Integer status = 1;

    @Column(name = "Quantity", nullable = false)
    private Integer quantity=0;

    @Column(name = "BookImage", nullable = false)
    private String bookImage;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ReleasedTime", columnDefinition = "TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss.SS")
    private Date releasedTime = new Date();


}
