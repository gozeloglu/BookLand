package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.model.projections.ExplorePageProjection;
import com.bookland.demobookland.model.projections.HotlistProjection;
import com.bookland.demobookland.model.validationGroups.AddBookGroup;
import com.bookland.demobookland.services.BookServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
public class BookController {
    @Autowired
    private BookServices bookServices;


    // GET All Books
    @GetMapping(value = "/allBooks/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ExplorePageProjection> getBooks(@PathVariable Integer pageNo, @PathVariable Integer pageSize) {
        /** @:return All books in JSON type
         *  GET request is handling here
         * */
        return bookServices.getAllBooks(pageNo - 1, pageSize);
    }


    @PostMapping(value = "/addBook")
    public String addBook(@Validated(AddBookGroup.class) @RequestBody Book book) {
        return bookServices.addBook(book);
    }

    @DeleteMapping(value = "/deleteBook/{id}")
    public String deleteBook(@PathVariable Integer id) {
        String response;
        try {
            bookServices.deleteBook(id);
            response = "Book Deleted";
            return response;
        } catch (Exception e) {
            response = "Some Problem Occured";
            return response;
        }
    }

    @PutMapping(value = "/updateBook/{id}")
    public String updateBook(@PathVariable Integer id, @RequestBody(required = false) Book book) {
        return bookServices.updateBook(id, book);
    }

    /*List of all distinct categories of books*/

    @GetMapping(value = "/getCategory", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<String> getCategory() {
        return bookServices.getCategory();
    }

    @GetMapping(value = "/getBookCount", produces = MediaType.APPLICATION_JSON_VALUE)
    public Long getBookCount() {
        return bookServices.getBookCount();
    }

    @GetMapping(value = "/getSubCategory", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<String> getSubCategory() {
        return bookServices.getSubCategory();
    }

    @GetMapping(value = "/getHotList", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<HotlistProjection> getHotList() {
        return bookServices.getHotList();
    }

    // GET All Books
    @GetMapping(value = "/getLastReleased", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Book> getLastReleased() {
        return bookServices.getLastReleased();
    }

    @GetMapping(value = "/getBookDetails/{ISBN}", produces = MediaType.APPLICATION_JSON_VALUE)
    public Book getBookById(@PathVariable Integer ISBN) {
        return bookServices.getBookById(ISBN);
    }

    @GetMapping(value = "/Search/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ExplorePageProjection> getBookBySearchCriteria(@PathVariable Integer pageNo, @PathVariable Integer pageSize, String keyword) {
        return bookServices.getBookBySearchCriteria(pageNo - 1, pageSize, keyword);
    }

    @PutMapping(value = "/applyDiscount/{book_id}/{percentage}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String applyDiscount(@PathVariable Integer book_id, @PathVariable Integer percentage) {
        return bookServices.applyDiscount(book_id, percentage);
    }

    @GetMapping(value = "/Filtering/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Book> getBookByFilters(@PathVariable Integer pageNo, @PathVariable Integer pageSize,
                                       @RequestParam(value = "author", defaultValue = "undefined") String author,
                                       @RequestParam(value = "categories", defaultValue = "") ArrayList<String> categories,
                                       @RequestParam(value = "minPrice", defaultValue = "-1") Integer minPrice,
                                       @RequestParam(value = "maxPrice", defaultValue = "-1") Integer maxPrice) {
        return bookServices.getBookByFilters(pageNo - 1, pageSize, author, categories, minPrice, maxPrice);
    }
}