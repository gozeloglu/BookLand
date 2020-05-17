package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Order;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends PagingAndSortingRepository<Order, Integer> {

    List<Order> findAllByCustomerId(Integer customerId);

    void deleteByCustomerIdAndOrderId(Integer customerId, Integer orderId);
}
