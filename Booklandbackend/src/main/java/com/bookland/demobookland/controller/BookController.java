package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.services.BookServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
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

    @PostMapping(value = "/addBook")
    public Book addBook(@Valid @RequestBody Book book){
        return bookServices.addBook(book);
    }

    @PostMapping(value = "/deleteBook")
    public void deleteBook(@Valid @RequestBody Book book){
         bookServices.deleteBook(book);
    }

    @PostMapping(value = "/updateBook")
    public void updateBook(@Valid @RequestBody Book book){
        bookServices.updateBook(book);
    }
    @PostMapping(value = "/getCategory")
    public List<Book> getCategory(@Valid @RequestBody Book book){
        return bookServices.getCategory(book);
    }
    @PostMapping(value = "/getSubCategory")
    public List<Book> getSubCategory(@Valid @RequestBody Book book){
        return bookServices.getSubCategory(book);
    }
    @PostMapping(value = "/getHotList")
    public List<Book> getHotList(@Valid @RequestBody Book book){
        return bookServices.getHotList(book);
    }
    // GET All Books
    @RequestMapping(value = "/getLastReleased", produces = MediaType.APPLICATION_JSON_VALUE, method = RequestMethod.GET)
    public List<Book> getLastReleased() {
        /** @:return All books in JSON type
         *  GET request is handling here
         * */
        return bookServices.getLastReleased();
    }

    @PostMapping(value = "/getBookById")
    public List<Book> getBookById(@Valid @RequestBody Book book){
        return bookServices.getBookById(book);
    }


}