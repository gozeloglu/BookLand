package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Contains;
import com.bookland.demobookland.model.ContainsPk;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ContainsRepository extends PagingAndSortingRepository<Contains, ContainsPk> {
}
