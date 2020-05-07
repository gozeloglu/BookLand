package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Search;
import com.bookland.demobookland.model.projections.KeywordProjection;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

public interface SearchRepository extends PagingAndSortingRepository<Search, Integer> {

    List<KeywordProjection> findTop10ByCustomerIdOrderByReleasedTimeDesc(Integer customerId);

}
