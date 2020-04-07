package com.bookland.demobookland.services;

import com.bookland.demobookland.repository.AddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class CustomerAddressServices {

    @Autowired/*Injection of repository*/
    private CustomerAddressServices customerAddressServices;

    
}
