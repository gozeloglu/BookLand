package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Campaign;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CampaignRepository extends PagingAndSortingRepository<Campaign,Integer> {

    Campaign findByCouponCode(String couponCode);

}
