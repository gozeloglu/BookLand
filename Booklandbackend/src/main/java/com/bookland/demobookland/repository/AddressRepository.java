package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Address;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AddressRepository extends PagingAndSortingRepository<Address,Integer> {
}
