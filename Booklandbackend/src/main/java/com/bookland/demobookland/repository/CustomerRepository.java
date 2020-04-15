package com.bookland.demobookland.repository;


import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.ExplorePageProjection;
import com.bookland.demobookland.model.projections.LoginInterface;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerRepository extends CrudRepository<Customer,Integer> {

   Customer findByEmail(String email);
   LoginInterface findAllByEmail(String email);
   //LoginInterface findByEmailProjectedBy(String email);


}
