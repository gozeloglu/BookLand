package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.ShippingCompany;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ShippingCompanyRepository extends PagingAndSortingRepository<ShippingCompany,Integer> {
}
