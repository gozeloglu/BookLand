package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.ShippingCompany;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShippingCompanyRepository extends PagingAndSortingRepository<ShippingCompany,Integer> {

    List<ShippingCompany> findAll();
}
