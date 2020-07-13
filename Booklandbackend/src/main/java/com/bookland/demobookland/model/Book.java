package com.bookland.demobookland.model;

import com.bookland.demobookland.model.validationGroups.AddBookGroup;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import javax.persistence.*;
import javax.validation.GroupSequence;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Entity
@Data
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "book")
@GroupSequence({Book.class, AddBookGroup.class})
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ISBN", nullable = false)
    private Integer bookId;

    @Column(name = "Real_Isbn", nullable = false)
    @NotNull(message = "ISBN cannot be empty", groups = AddBookGroup.class)
    private Long realIsbn;

    @Column(name = "BookName", nullable = false)
    @NotBlank(message = "Book name cannot be empty", groups = AddBookGroup.class)
    private String bookName;

    @Column(name = "Author", nullable = false)
    @NotBlank(message = "Author field cannot be empty", groups = AddBookGroup.class)
    private String author;

    @Column(name = "Description")
    private String description;

    @Column(name = "Category", nullable = false)
    @NotBlank(message = "Category field cannot be empty", groups = AddBookGroup.class)
    private String category;

    @Column(name = "SubCategory")
    @NotBlank(message = "Sub-Category field cannot be empty", groups = AddBookGroup.class)
    private String subCategory;

    @Column(name = "InHotList")
    private Integer inHotList;

    @Column(name = "InDiscount")
    private Integer inDiscount=0;

    @Column(name = "Quantity", nullable = false)
    @NotNull(message = "Quantity field cannot be empty", groups = AddBookGroup.class)
    @Min(value = 1, groups = AddBookGroup.class, message = "Quantity must be more than zero")
    private Integer quantity /*= 0*/;

    @Column(name = "BookImage", nullable = false)
    @NotBlank(message = "Book image cannot be empty", groups = AddBookGroup.class)
    private String bookImage;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ReleasedTime", columnDefinition = "TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss.SS")
    private Date releasedTime = new Date();

    @Valid
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "bookPrices")/*kitabı silince price da silinsin istiyosak cascade all*/
    @NotNull(message = "Define a price", groups = AddBookGroup.class)
    private List<Price> priceList;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "bookComment")
    private List<Comment> commentList;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "bookVote")
    private List<Vote> voteList;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "book")
    private List<Contains> containsList;
}
