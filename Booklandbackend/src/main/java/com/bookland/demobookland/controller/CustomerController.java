package com.bookland.demobookland.controller;


import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.services.CustomerServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
public class CustomerController {

        @Autowired
        PasswordEncoder encoder;

        @Autowired
        private CustomerServices customerServices;

        @GetMapping(value = "/allCustomers",produces = MediaType.APPLICATION_JSON_VALUE)
        public List<Customer> getCustomers(){
                return customerServices.getallCustomer();
        }

        @PostMapping(value = "/message")
        public String message(@RequestBody String s){
            return String.format("%s",s);
        }

        @PostMapping(value = "/saveCustomer")
        public Customer saveCustomer(@Valid @RequestBody Customer customer){
                //if(customerServices.UniqueEmail(customer.getEmail())==Boolean.TRUE)

                customer.setPassword(encoder.encode(customer.getPassword()));
                /*System.out.println(String.format("id= %d , name= %s, surname= %s, email= %s, password= %s",customer.getCustomerId(),
                        customer.getFirstName(),customer.getSurname(),customer.getEmail(),customer.getPassword()));*/
                return customerServices.saveCustomer(customer);
        }
}
