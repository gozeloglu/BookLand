package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.model.ExplorePageProjection;
import com.bookland.demobookland.model.HotlistProjection;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookRepository extends CrudRepository<Book, Integer> {
    /*,,b.priceList as priceList */
    /*@Query("SELECT  b.bookImage as bookImage, b.bookName as bookName," +
            "b.author as author,b.bookId as bookId,b.priceList as priceList FROM Book b")*/
    List<ExplorePageProjection> findAllProjectedBy();

    /*Find distinct categories*/
    @Query("SELECT DISTINCT b.category FROM Book b")
    List<String> findDistinctByCategory();

    /*Find distinct subcategories*/
    @Query("SELECT DISTINCT b.subCategory FROM Book b")
    List<String> findDistinctBySubCategory();

    Book findByBookId(Integer id);

    /*Last released 10 books*/
    List<Book> findTop10ByOrderByReleasedTimeDesc();

    /*If we want to return all the properties of book just change the return type to book*/
    @Query("SELECT  b.bookImage as bookImage, b.bookName as bookName FROM Book b WHERE b.inHotList=1")
    List<HotlistProjection> findByInHotList();

    List<Book> findByAuthorContains(String author);

    List<Book> findByBookNameContains(String bookName);

    List<Book> findByCategoryContains(String category);

    List<Book> findBySubCategoryContains(String subcategory);

}
