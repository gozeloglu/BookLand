package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Address;
import com.bookland.demobookland.repository.AddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;


@Service
public class AddressServices {

    @Autowired/*Injection of repository*/
    private AddressRepository addressRepository;

    @Transactional
    public Boolean saveAddress(Address address) {
        try {
            addressRepository.save(address);
            return true;
        }catch (Exception e){
            return false;
        }

    }
}
