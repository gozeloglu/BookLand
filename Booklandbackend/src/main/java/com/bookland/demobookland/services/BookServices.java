package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.repository.BookRepository;
import org.hibernate.exception.SQLGrammarException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class BookServices {

    @Autowired
    private BookRepository bookRepository;

    /** @:return All books are returned in database
     *  All books are retrieved from database
     *  bookList stores the Book objects
     * */
    public List<Book> getAllBooks() {
        List<Book> bookList = new ArrayList<>();
        for (Book book : bookRepository.findAll()) {
            bookList.add(book);
        }
        return bookList;
    }
}
