package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Card;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PaymentRepository extends PagingAndSortingRepository<Card, String> {
    Card findByCardNo(String cardNo);
}
