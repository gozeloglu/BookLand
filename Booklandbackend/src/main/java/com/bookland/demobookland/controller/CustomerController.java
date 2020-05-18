package com.bookland.demobookland.controller;


import com.bookland.demobookland.model.Comment;
import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.LoginInterface;
import com.bookland.demobookland.model.validationGroups.LoginGroup;
import com.bookland.demobookland.model.validationGroups.SignUpGroup;
import com.bookland.demobookland.services.CustomerServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
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

    @PostMapping(value = "/makeComment/{bookId}/{customerId}")
    public Comment comment(@PathVariable Integer bookId, @PathVariable Integer customerId, @RequestBody Comment comment) {
        return customerServices.comment(bookId, customerId, comment);
    }

    @PostMapping(value = "/updateCustomer/{customerId}")
    public Customer updateCustomer(@PathVariable Integer customerId, @RequestBody Customer customer) throws LoginException {
        return customerServices.updateCustomer(customer, customerId);
    }

    /*@PostMapping(value = "/doComment")
    public Comment comment(@RequestBody Comment comment) {
        return customerServices.comment(comment);
    }*/
}
