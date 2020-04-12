package com.bookland.demobookland.repository;


import com.bookland.demobookland.model.Price;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public interface PriceRepository extends CrudRepository<Price, Date> {
}
