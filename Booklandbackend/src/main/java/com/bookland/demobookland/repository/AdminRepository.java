package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Admin;
import org.springframework.data.repository.CrudRepository;

public interface AdminRepository  extends CrudRepository<Admin,Integer> {
    // Admin findbyID(Integer id);
}




