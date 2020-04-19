package com.bookland.demobookland.repository;


import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.CustomerInfoProjection;
import com.bookland.demobookland.model.projections.LoginInterface;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerRepository extends PagingAndSortingRepository<Customer,Integer> {

   Customer findByEmail(String email);
   LoginInterface findAllByEmail(String email);
   Page<CustomerInfoProjection> findAllProjectedBy(Pageable paging);

   //LoginInterface findByEmailProjectedBy(String email);


}
