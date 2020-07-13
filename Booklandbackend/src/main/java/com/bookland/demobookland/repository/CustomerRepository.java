package com.bookland.demobookland.repository;


import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.CustomerInfoProjection;
import com.bookland.demobookland.model.projections.LoginInterface;
import com.bookland.demobookland.model.projections.UserSearchProjection;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CustomerRepository extends PagingAndSortingRepository<Customer, Integer> {

    Customer findByEmail(String email);

    Customer findByCustomerId(Integer id);

    Page<UserSearchProjection> findByCustomerId(Pageable paging, Integer id);

    List<UserSearchProjection> findAllByCustomerId(Integer id);

    LoginInterface findAllByEmail(String email);

    Page<CustomerInfoProjection> findAllProjectedBy(Pageable paging);

    CustomerInfoProjection findByIsAdminEquals(Integer constant_value);

    Page<UserSearchProjection> findByFirstNameContainsOrSurnameContainsOrEmailContains(Pageable paging, String keyword1, String keyword2, String keyword3);

    List<UserSearchProjection> findByFirstNameContainsOrSurnameContainsOrEmailContains(String keyword1, String keyword2, String keyword3);
}
