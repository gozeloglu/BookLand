package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Service
public class BookServices {

    private static Book ReleasedTimeComparator;
    @Autowired
    private BookRepository bookRepository;

    /**
     * @:return All books are returned in database
     * All books are retrieved from database
     * bookList stores the Book objects
     */
    public List<Book> getAllBooks() {
        List<Book> bookList = new ArrayList<>();
        for (Book book : bookRepository.findAll()) {
            bookList.add(book);
        }
        return bookList;
    }

    /* Add operation for book*/


    @Transactional
    public String addBook(Book book) {
        String response;
        try {
            bookRepository.save(book);
            response = "Book added";
            return response;
        } catch (Exception e) {
            response = " Book could not added.";
            return response;
        }


    }

    /* Delete operation for book*/

    @Transactional
    public void deleteBook(int id) {
        bookRepository.deleteById(id);
    }

    /* Update operations for book*/

    @Transactional
    public String updateBook(Integer id, Book book) {
        String response;
        try {

            Book current_book = bookRepository.findByBookId(id);

            if (book.getAuthor() != null) {
                current_book.setAuthor(book.getAuthor());
            }
            if (book.getBookName() != null) {
                current_book.setBookName(book.getBookName());
            }
            if (book.getCategory() != null) {
                current_book.setCategory(book.getCategory());
            }
            if (book.getSubCategory() != null) {
                current_book.setSubCategory(book.getSubCategory());
            }
            if (book.getInHotList() != null) {
                current_book.setInHotList(book.getInHotList());
            }
            if (book.getDescription() != null) {
                current_book.setDescription(book.getDescription());
            }
            if (book.getBookImage() != null) {
                current_book.setBookImage(book.getBookImage());
            }
            if (book.getQuantity() != 0) {
                current_book.setQuantity(book.getQuantity());
            }
            bookRepository.save(current_book);
            response = "Book Properties Updated";
            return response;
        } catch (Exception e) {
            response = "Book cannot updated";
            return response;
        }

    }

    /*Get distinct categories*/

    public List<String> getCategory() {
        return bookRepository.findDistinctByCategory();
    }

    /*Get distinct sub-categories*/


    public List<String> getSubCategory() {
        return bookRepository.findDistinctBySubCategory();
    }

    /*Get hot-list*/
    public List<String> getHotList() {
        return bookRepository.findByInHotList();
    }

    /*get last released books limit 10*/
    public List<Book> getLastReleased() {
       return bookRepository.findTop10ByOrderByReleasedTimeDesc();
    }

    /*Get book details by id*/
    public Book getBookById(Integer ISBN) {
        return bookRepository.findByBookId(ISBN);
    }

    /*get all books when you search the key word book_author
    * it will bring all the books which contains the searched author name*/
    public List<Book> getBookByAuthor(String book_author) {
        return bookRepository.findByAuthorContains(book_author);
    }

    /*get all books when you search the key word bookName
     * it will bring all the books which contains the searched author name*/
    public List<Book> getBookByTitle(String bookName) {
       return  bookRepository.findByBookNameContains(bookName);
    }

    /*get all books when you search the key word bookName
     * it will bring all the books which contains the searched author name*/
    public List<Book> getBookByCategory(String bookName) {
        return  bookRepository.findByCategoryContains(bookName);
    }

    /*get all books when you search the key word bookName
     * it will bring all the books which contains the searched author name*/
    public List<Book> getBookBySubCategory(String bookName) {
        return  bookRepository.findBySubCategoryContains(bookName);
    }
}
