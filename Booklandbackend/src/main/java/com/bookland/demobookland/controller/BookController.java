package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.model.projections.BestSellerProjection;
import com.bookland.demobookland.model.projections.BookDetailsProjection;
import com.bookland.demobookland.model.projections.CartDetailProjection;
import com.bookland.demobookland.model.projections.ExplorePageProjection;
import com.bookland.demobookland.model.validationGroups.AddBookGroup;
import com.bookland.demobookland.services.BookServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
public class BookController {
    @Autowired
    private BookServices bookServices;


    // GET All Books
    @GetMapping(value = "/allBooks/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ExplorePageProjection> getBooks(@PathVariable Integer pageNo, @PathVariable Integer pageSize) {
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
    public String updateBook(@PathVariable Integer id, @RequestBody Book book) { //{required false varmış
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

    @GetMapping(value = "/getBookCountByCategory/{category}", produces = MediaType.APPLICATION_JSON_VALUE)
    public Long getBookCountByCategory(@PathVariable String category) {
        return bookServices.getBookCountByCategory(category);
    }

    @GetMapping(value = "/getBookCountHotList", produces = MediaType.APPLICATION_JSON_VALUE)
    public Long getBookCountByCategory() {
        return bookServices.getBookCountByHotList();
    }

    @GetMapping(value = "/getSubCategory", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<String> getSubCategory() {
        return bookServices.getSubCategory();
    }

    @GetMapping(value = "/getHotList/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ExplorePageProjection> getHotList(@PathVariable Integer pageNo, @PathVariable Integer pageSize) {
        return bookServices.getHotList(pageNo - 1, pageSize);
    }

    @GetMapping(value = "/getLastReleased/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ExplorePageProjection> getLastReleased(@PathVariable Integer pageNo, @PathVariable Integer pageSize) {
        return bookServices.getLastReleased(pageNo - 1, pageSize);
    }

    @GetMapping(value = "/getBookDetails/{ISBN}", produces = MediaType.APPLICATION_JSON_VALUE)
    public BookDetailsProjection getBookById(@PathVariable Integer ISBN) {
        return bookServices.getBookById(ISBN);
    }

    @PutMapping(value = "/applyDiscount/{book_id}/{percentage}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String applyDiscount(@PathVariable Integer book_id, @PathVariable Integer percentage) {
        return bookServices.applyDiscount(book_id, percentage);
    }

    @GetMapping(value = "/getBookByCategoryName/{pageNo}/{pageSize}/{category}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ExplorePageProjection> getBookByCategory(@PathVariable Integer pageNo, @PathVariable Integer pageSize, @PathVariable String category) {
        System.out.println(category);
        return bookServices.getBookByCategory(pageNo - 1, pageSize, category);
    }

    @GetMapping(value = "/Filtering/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<BookDetailsProjection> getBookByFilters(@PathVariable Integer pageNo, @PathVariable Integer pageSize,
                                                        @RequestParam(value = "author", defaultValue = "undefined") String author,
                                                        @RequestParam(value = "categories", defaultValue = "") ArrayList<String> categories,
                                                        @RequestParam(value = "minPrice", defaultValue = "-1") Integer minPrice,
                                                        @RequestParam(value = "maxPrice", defaultValue = "-1") Integer maxPrice) {
        return bookServices.getBookByFilters(pageNo - 1, pageSize, author, categories, minPrice, maxPrice);
    }

    @GetMapping(value = "/getBookCountByFilters", produces = MediaType.APPLICATION_JSON_VALUE)
    public Long getBookCountByFilters(@RequestParam(value = "author", defaultValue = "undefined") String author,
                                      @RequestParam(value = "categories", defaultValue = "") ArrayList<String> categories,
                                      @RequestParam(value = "minPrice", defaultValue = "-1") Integer minPrice,
                                      @RequestParam(value = "maxPrice", defaultValue = "-1") Integer maxPrice) {
        return bookServices.getBookCountByFilters(author, categories, minPrice, maxPrice);
    }

    @PostMapping(value = "/cartDetails", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<CartDetailProjection> showBooksInCart(@RequestBody Map<String, List<String>> BookIds) {
        return bookServices.cartDetails(BookIds);
    }

    @GetMapping(value = "/getBestSeller/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<BestSellerProjection> getBestSeller(@PathVariable Integer pageNo, @PathVariable Integer pageSize) {
        return bookServices.getBestSellers();
    }
}