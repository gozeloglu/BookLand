package com.bookland.demobookland.services;

import com.bookland.demobookland.repository.ShippinCompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShippingServices {
    @Autowired
    private ShippinCompanyRepository shippinCompanyRepository;
}
