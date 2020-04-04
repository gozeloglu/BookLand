package com.bookland.demobookland.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@Table(name="book")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ISBN", nullable = false, unique = true)
    private int bookId;

    @Column(name = "BookName", nullable = false)
    private String bookName;

    @Column(name = "Author", nullable = false)
    private String author;

    @Column(name = "Description")
    private String description;

    @Column(name = "Category", nullable = false)
    private String category;

    @Column(name = "SubCategory", nullable = false)
    private String subCategory;

    @Column(name = "InHotList", nullable = false)
    private int inHotList;

    @Column(name = "Status", nullable = false)
    private int status;

    @Column(name = "BookImage", nullable = false)
    private String bookImage;

    @Column(name = "ReleasedTime", nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date releasedTime;
}
