package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
public class CustomerServices {
    @Autowired/*Injection of repository*/
    private CustomerRepository customerRepository;

    public List<Customer> getallCustomer() {
        List<Customer> customerList = new ArrayList<>();
        for (Customer customer : customerRepository.findAll()) {
            customerList.add(customer);
        }
        return customerList;
    }


    /*Saving the registered customer to the database*/
    @Transactional
    public Customer saveCustomer(Customer customer) {
        return customerRepository.save(customer);
    }

    public Boolean UniqueEmail(String email){
        return customerRepository.findByEmail(email);
    }

}
