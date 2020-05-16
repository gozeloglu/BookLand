package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Comment;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.CriteriaBuilder;

@Repository
public interface CommentRepository extends PagingAndSortingRepository<Comment, Integer> {

}
