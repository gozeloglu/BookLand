package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service

public class CustomerServices {
    /*Injection of repository*/
    @Autowired
    PasswordEncoder encoder;

    @Autowired
    private CustomerRepository customerRepository;

    public List<Customer> getallCustomer() {
        List<Customer> customerList = new ArrayList<>();
        for (Customer customer : customerRepository.findAll()) {
            customerList.add(customer);
        }
        return customerList;
    }


    /*Saving the registered customer to the database and return the id of the new customer*/
    @Transactional
    public Integer saveCustomer(Customer customer) {
        Customer existingCustomer = customerRepository.findByEmail(customer.getEmail());
        if (existingCustomer == null) {
            customerRepository.save(customer);
            return customer.getCustomerId();
        } else {
            return 0;
        }
    }


    /*Returns existing customer id if login is successful*/
    public Integer getLogin(Customer customer) {
        Customer loginUser = customerRepository.findByEmail(customer.getEmail());

        if (loginUser != null) {
            if (encoder.matches(customer.getPassword(), loginUser.getPassword())) {
                return loginUser.getCustomerId();
            }
        }
        return 0;
    }

}
