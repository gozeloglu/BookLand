package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.model.projections.ExplorePageProjection;
import com.bookland.demobookland.model.projections.HotlistProjection;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookRepository extends PagingAndSortingRepository<Book, Integer>, JpaSpecificationExecutor<Book> {

    Page<ExplorePageProjection> findAllProjectedBy(Pageable paging);

    /*Find distinct categories*/
    @Query("SELECT DISTINCT b.category FROM Book b")
    List<String> findDistinctByCategory();

    /*Find distinct subcategories*/
    @Query("SELECT DISTINCT b.subCategory FROM Book b")
    List<String> findDistinctBySubCategory();

    Book findByBookId(Integer id);

    /*Last released 10 books*/
    List<ExplorePageProjection> findTop10ByOrderByReleasedTimeDesc();

    /*If we want to return all the properties of book just change the return type to book*/
    @Query("SELECT  b.bookImage as bookImage, b.bookName as bookName FROM Book b WHERE b.inHotList=1")
    List<HotlistProjection> findByInHotList();

    Page<ExplorePageProjection> findByRealIsbn(Pageable paging, Long isbn);

    List<ExplorePageProjection> findByRealIsbn(Long isbn);

    Page<ExplorePageProjection> findByAuthorContainsOrBookNameContainsOrCategoryContainsOrSubCategoryContains(Pageable paging, String searchedItem, String searchedItem1, String searchedItem2, String searchedItem3);

    List<ExplorePageProjection> findTop10ByAuthorContainsOrBookNameContainsOrCategoryContainsOrSubCategoryContains(String searchedItem, String searchedItem1, String searchedItem2, String searchedItem3);

}
