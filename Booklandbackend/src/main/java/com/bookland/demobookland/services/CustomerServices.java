package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.CustomerInfoProjection;
import com.bookland.demobookland.model.projections.ExplorePageProjection;
import com.bookland.demobookland.model.projections.LoginInterface;
import com.bookland.demobookland.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.security.auth.login.LoginException;
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

    public List<CustomerInfoProjection> getallCustomer(Integer pageNo, Integer pageSize) {
        Pageable paging = PageRequest.of(pageNo, pageSize);

        Page<CustomerInfoProjection> pagedResult = customerRepository.findAllProjectedBy(paging);

        return pagedResult.toList();
    }


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

        if (loginUser != null) {
            if (encoder.matches(customer.getPassword(), loginUser.getPassword())) {
                return loginUser;
            } else {
                throw new LoginException("Password or Username is incorrect");
            }
        } else {
            throw new LoginException("User not found");
        }
    }

}
