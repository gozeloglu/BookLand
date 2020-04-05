package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.services.BookServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class BookController {
    @Autowired
    private BookServices bookServices;

    // GET All Books
    @RequestMapping(value = "/allBooks", produces = MediaType.APPLICATION_JSON_VALUE, method = RequestMethod.GET)
    public List<Book> getBooks() {
        /** @:return All books in JSON type
         *  GET request is handling here
         * */
        return bookServices.getAllBooks();
    }
}