package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Book;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends CrudRepository<Book, Integer> {

    Boolean getAll();

}
