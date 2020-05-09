package com.bookland.demobookland.services;

import com.bookland.demobookland.model.projections.CustomerInfoProjection;
import com.bookland.demobookland.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServices {

    @Autowired
    private CustomerRepository customerRepository;

    public CustomerInfoProjection getAdmin() {
        return customerRepository.findByIsAdminEquals(1);
    }
}



