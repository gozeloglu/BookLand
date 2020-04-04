package com.bookland.demobookland.model;

import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
@Data
@Table(name="book")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ISBN", nullable = false)
    private int bookId;

    @Column(name = "BookName", nullable = false)
    private String bookName;

    @Column(name = "author", nullable = false)
    private String author;

    @Column(name = "Description", nullable = false)
    private String description;

    @Column(name = "Category", nullable = false)
    private String category;

    @Column(name = "SubCategory", nullable = false)
    private String subCategory;

    @Column(name = "In-Hotlist", nullable = false)
    private boolean inHotList;

    @Column(name = "Status", nullable = false)
    private int status;

    @Column(name = "BookImage", nullable = false)
    private String bookImage;

    // TODO Relased time should be added --> Look at customer class (date of birth)
}
