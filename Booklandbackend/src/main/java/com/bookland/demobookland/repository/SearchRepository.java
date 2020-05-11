package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Search;
import com.bookland.demobookland.model.projections.KeywordProjection;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SearchRepository extends PagingAndSortingRepository<Search, Integer> {

    List<KeywordProjection> findTop10ByCustomerIdOrderByReleasedTimeDesc(Integer customerId);

}
