package com.bookland.demobookland.controller;


import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.LoginInterface;
import com.bookland.demobookland.model.validationGroups.LoginGroup;
import com.bookland.demobookland.model.validationGroups.SignUpGroup;
import com.bookland.demobookland.services.CustomerServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.security.auth.login.LoginException;

@RestController
public class CustomerController {


    @Autowired
    private CustomerServices customerServices;


    @PostMapping(value = "/saveCustomer")
    public Integer saveCustomer(@Validated(SignUpGroup.class) @RequestBody Customer customer) {
        return customerServices.saveCustomer(customer);
    }

    @PostMapping(value = "/login")
    public LoginInterface getLogin(@Validated(LoginGroup.class) @RequestBody Customer customer) throws LoginException {
        return customerServices.getLogin(customer);
    }


}
