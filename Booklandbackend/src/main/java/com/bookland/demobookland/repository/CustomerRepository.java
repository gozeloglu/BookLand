package com.bookland.demobookland.repository;


import com.bookland.demobookland.model.Customer;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Repository;

//@NoRepositoryBean
@Repository
public interface CustomerRepository extends CrudRepository<Customer,Integer> {

   Boolean findByEmail(String email);

}
