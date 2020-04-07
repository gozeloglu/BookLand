package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Address;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AddressRepository extends CrudRepository<Address,Integer> {

}
