package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.CustomerAddress;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CustomerAddressRepository extends CrudRepository<CustomerAddress, Integer> {
    List<CustomerAddress> findByCustomerId(int id);

    CustomerAddress findByCustomerIdAndAddressId(int customer_id, int address_id);
}
