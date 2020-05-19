package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.PurchasedDetailedInfo;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PurchaseDetailRepository extends PagingAndSortingRepository<PurchasedDetailedInfo,Integer> {
}
