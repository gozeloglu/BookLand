package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;

@Service
public class BookServices {

    private static Book ReleasedTimeComparator;
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
    @Transactional
    public Book addBook(Book book) {
        return bookRepository.save(book);
    }


    @Transactional
    public void deleteBook(Book book) {
        Integer delete_id = book.getBookId();
        bookRepository.deleteById(delete_id);
    }

    @Transactional
    public void updateBook(Book book) {
        String changedAuthor = book.getAuthor();
        String changedName =   book.getBookName();
        String changedDescription = book.getDescription();
        String changedCategory = book.getCategory();
        Integer inhotList = book.getInHotList();
        String changedsubCat = book.getSubCategory();
        Optional<Book> bookOptional = bookRepository.findById(book.getBookId());
        if (bookOptional.isPresent()){
            Book bookObj = bookOptional.get();
            if ((changedAuthor != null)){
                bookObj.setAuthor(changedAuthor);
            }
            if ( changedName != null){
                bookObj.setBookName(changedName);
            }if ( changedDescription != null){
                bookObj.setDescription(changedDescription);
            }if ( changedCategory != null){
                bookObj.setCategory(changedCategory);
            }if ( inhotList != null){
                bookObj.setInHotList(inhotList);
            }if ( changedsubCat != null){
                bookObj.setSubCategory(changedsubCat);
            }
        }

    }
    public List<Book> getCategory(Book book_category) {
        List<Book> bookList = new ArrayList<>();
        for (Book book : bookRepository.findAll()) {

            if( book.getCategory().equalsIgnoreCase(book_category.getCategory())){
                bookList.add(book);
            }
        }

        return bookList;
    }

    public List<Book> getSubCategory(Book book_subcategory) {
        List<Book> bookList = new ArrayList<>();
        for (Book book : bookRepository.findAll()) {
            if( book.getSubCategory().equalsIgnoreCase(book_subcategory.getSubCategory())){
                bookList.add(book);
            }
        }
        return bookList;
    }
    public List<Book> getHotList(Book book_hotList) {
        List<Book> bookList = new ArrayList<>();
        for (Book book : bookRepository.findAll()) {
            if( book.getInHotList() ==  book_hotList.getInHotList()){
                bookList.add(book);
            }
        }
        return bookList;
    }
    public class ReleasedTimeComparator implements Comparator<Book> {
        @Override
        public int compare(Book o1, Book o2) {
            return o1.getReleasedTime().compareTo(o2.getReleasedTime());
        }
    }
    public List<Book> getLastReleased() {
        List<Book> bookList = new ArrayList<>();
        for (Book book : bookRepository.findAll()) {
                bookList.add(book);
        }
        Collections.sort(bookList, new BookServices.ReleasedTimeComparator());
        Collections.reverse(bookList);
        return bookList;
    }


    public List<Book> getBookById(Book book_isbn) {
        List<Book> bookList = new ArrayList<>();
        for (Book book : bookRepository.findAll()) {
            if( book.getBookId() ==  book_isbn.getBookId()){
                bookList.add(book);
            }
        }
        return bookList;
    }


}
