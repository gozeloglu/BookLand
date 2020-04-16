package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.model.projections.ExplorePageProjection;
import com.bookland.demobookland.model.projections.HotlistProjection;
import com.bookland.demobookland.services.BookServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
public class BookController {
    @Autowired
    private BookServices bookServices;


    // GET All Books
    @GetMapping(value = "/allBooks/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ExplorePageProjection> getBooks(@PathVariable Integer pageNo,@PathVariable Integer pageSize) {
        /** @:return All books in JSON type
         *  GET request is handling here
         * */
        return bookServices.getAllBooks(pageNo,pageSize);
    }

    @PostMapping(value = "/addBook")
    public String addBook(@Valid @RequestBody Book book) {
        return bookServices.addBook(book);
    }

    @DeleteMapping(value = "/deleteBook/{id}")
    public String deleteBook(@PathVariable Integer id) {
        String response;
        try {
            bookServices.deleteBook(id);
            response = "Book Deleted";
            return response;
        }catch (Exception e){
            response = "Some Problem Occured";
            return response;
        }

    }

    @PutMapping(value = "/updateBook/{id}")
    public String updateBook(@PathVariable Integer id, @Valid @RequestBody Book book) {
        return bookServices.updateBook(id,book);
    }

    /*List of all distinct categories of books*/

    @GetMapping(value = "/getCategory", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<String> getCategory() {
        return bookServices.getCategory();
    }

    @GetMapping(value = "/getSubCategory",produces = MediaType.APPLICATION_JSON_VALUE)
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

    /*Ana sayfada resmin üzerine basınca bu fonksiyon çalışıcak
    * ISBN ye göre aramak isterse de aynısı çalışcak çünkü ISBN unique*/
    @GetMapping(value = "/getBookDetails/{ISBN}", produces = MediaType.APPLICATION_JSON_VALUE)
    public Book getBookById(@PathVariable Integer ISBN) {
        return bookServices.getBookById(ISBN);
    }

    @GetMapping(value = "/SearchByAuthor",produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Book> getBookByAuthor(String author) {
        return bookServices.getBookByAuthor(author);
    }

    @GetMapping(value = "/SearchByBookName",produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Book> getBookByName(String bookName) {
        return bookServices.getBookByTitle(bookName);
    }

    @GetMapping(value = "/SearchByCategory",produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Book> getBookByCategory(String category) {
        return bookServices.getBookByCategory(category);
    }

    @GetMapping(value = "/SearchBySubCategory",produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Book> getBookBySubCategory(String subCategory) {
        return bookServices.getBookBySubCategory(subCategory);
    }

    @PutMapping(value = "/applyDiscount/{book_id}/{percentage}",produces = MediaType.APPLICATION_JSON_VALUE)
    public String applyDiscount(@PathVariable Integer book_id,@PathVariable Integer percentage){
        return bookServices.applyDiscount(book_id,percentage);
    }
    @GetMapping(value = "/hello",produces = MediaType.APPLICATION_JSON_VALUE)
    public String hello(String isbn) {
        return "{isbn:'1', bookname:'İçimizdeki Şeytan'}";
    }


}