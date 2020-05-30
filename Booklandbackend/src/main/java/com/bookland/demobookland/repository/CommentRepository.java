package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Comment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentRepository extends PagingAndSortingRepository<Comment, Integer> {

    Page<Comment> findAllByBookId(Pageable paging, Integer bookId);

    Long countByBookIdEquals(Integer isbn);

}
