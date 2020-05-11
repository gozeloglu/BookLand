package com.bookland.demobookland.services;

import com.bookland.demobookland.repository.ShippingCompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShippingServices {
    @Autowired
    private ShippingCompanyRepository shippingCompanyRepository;
}
