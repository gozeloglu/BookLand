package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Campaign;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CampaignRepository extends PagingAndSortingRepository<Campaign, Integer> {

    Campaign findByCouponCode(String couponCode);

    Page<Campaign> findAll(Pageable paging);
}
