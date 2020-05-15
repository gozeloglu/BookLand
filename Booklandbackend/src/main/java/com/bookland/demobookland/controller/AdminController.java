package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.projections.CustomerInfoProjection;
import com.bookland.demobookland.services.AdminServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class AdminController {

    @Autowired
    private AdminServices adminServices;

    @GetMapping(value = "/getAdmin", produces = MediaType.APPLICATION_JSON_VALUE)
    public CustomerInfoProjection getAdmin() {
        return adminServices.getAdmin();
    }

    @GetMapping(value = "/manageCustomers/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<CustomerInfoProjection> getCustomers(@PathVariable Integer pageNo, @PathVariable Integer pageSize) {
        return adminServices.manageCustomers(pageNo - 1, pageSize);
    }

    @PutMapping(value = "/deActivateAccount/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String applyDiscount(@PathVariable Integer customerId) {
        return adminServices.deActivateAccount(customerId);
    }
}



