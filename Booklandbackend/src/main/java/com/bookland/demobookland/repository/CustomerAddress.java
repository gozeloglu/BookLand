package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.CustomerAddressPk;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerAddress extends CrudRepository<CustomerAddress, CustomerAddressPk> {
}
