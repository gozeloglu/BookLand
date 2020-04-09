package com.bookland.demobookland.services;

import com.bookland.demobookland.model.CustomerAddress;
import com.bookland.demobookland.repository.CustomerAddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;


@Service
public class CustomerAddressServices {

    @Autowired/*Injection of repository*/
    private CustomerAddressRepository customerAddressRepository;


    @Transactional
    public Boolean CreateCustomerAddress(CustomerAddress customerAddress) {
        try {
            customerAddressRepository.save(customerAddress);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<CustomerAddress> showAddresses(int id) {
        return customerAddressRepository.findByCustomerId(id);
    }


}
