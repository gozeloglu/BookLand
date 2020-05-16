package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.LoginInterface;
import com.bookland.demobookland.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.security.auth.login.LoginException;
import javax.transaction.Transactional;

@Service

public class CustomerServices {
    /*Injection of repository*/
    @Autowired
    PasswordEncoder encoder;

    @Autowired
    private CustomerRepository customerRepository;

    /*Saving the registered customer to the database and return the id of the new customer*/
    @Transactional
    public Integer saveCustomer(Customer customer) {
        Customer existingCustomer = customerRepository.findByEmail(customer.getEmail());
        if (existingCustomer == null) {
            String encodedPassword = new BCryptPasswordEncoder().encode(customer.getPassword());
            customer.setPassword(encodedPassword);
            customerRepository.save(customer);
            return customer.getCustomerId();
        } else {
            return 0;
        }
    }


    /*Returns existing customer id if login is successful*/
    public LoginInterface getLogin(Customer customer) throws LoginException {
        LoginInterface loginUser = customerRepository.findAllByEmail(customer.getEmail());
        Customer customer1 = customerRepository.findByEmail(customer.getEmail());
        if (loginUser != null) {
            if (customer1 != null && customer1.getStatus() != 0) {
                if (encoder.matches(customer.getPassword(), loginUser.getPassword())) {
                    return loginUser;
                } else {
                    throw new LoginException("Password or Username is incorrect");
                }
            } else {
                throw new LoginException("User Deactivated");
            }
        } else {
            throw new LoginException("User not found");
        }

    }
}
