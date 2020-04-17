package com.bookland.demobookland.controller;


import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.CustomerInfoProjection;
import com.bookland.demobookland.model.projections.LoginInterface;
import com.bookland.demobookland.model.validationGroups.LoginGroup;
import com.bookland.demobookland.model.validationGroups.SignUpGroup;
import com.bookland.demobookland.services.CustomerServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.security.auth.login.LoginException;
import java.util.List;

@RestController
public class CustomerController {


    @Autowired
    private CustomerServices customerServices;

    @GetMapping(value = "/allCustomers/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<CustomerInfoProjection> getCustomers(@PathVariable Integer pageNo, @PathVariable Integer pageSize) {
        return customerServices.getallCustomer(pageNo, pageSize);
    }

    @PostMapping(value = "/saveCustomer")
    public Integer saveCustomer(@Validated(SignUpGroup.class) @RequestBody Customer customer) {
        return customerServices.saveCustomer(customer);
    }

    @PostMapping(value = "/login")
    public LoginInterface getLogin(@Validated(LoginGroup.class) @RequestBody Customer customer) throws LoginException {
        return customerServices.getLogin(customer);
    }


}
