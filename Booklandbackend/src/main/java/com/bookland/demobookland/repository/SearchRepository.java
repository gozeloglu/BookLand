package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Search;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface SearchRepository extends PagingAndSortingRepository<Search, Integer> {
}
