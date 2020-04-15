package com.bookland.demobookland.controller;


import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.LoginInterface;
import com.bookland.demobookland.services.CustomerServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.List;

@RestController
public class CustomerController {

    @Autowired
    PasswordEncoder encoder;

    @Autowired
    private CustomerServices customerServices;

    @GetMapping(value = "/allCustomers", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Customer> getCustomers() {
        return customerServices.getallCustomer();
    }

    @PostMapping(value = "/saveCustomer")
    public Integer saveCustomer(@Valid @RequestBody Customer customer) {
        customer.setPassword(encoder.encode(customer.getPassword()));
        return customerServices.saveCustomer(customer);
    }

    @PostMapping(value = "/login")
    public LoginInterface getLogin(@Valid @RequestBody Customer customer) {
        return customerServices.getLogin(customer);
    }


}
