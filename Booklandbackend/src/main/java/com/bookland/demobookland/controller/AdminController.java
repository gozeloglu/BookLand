package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.model.Campaign;
import com.bookland.demobookland.model.projections.CustomerInfoProjection;
import com.bookland.demobookland.model.validationGroups.AddBookGroup;
import com.bookland.demobookland.services.AdminServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
public class AdminController {

    @Autowired
    private AdminServices adminServices;

    @GetMapping(value = "/getAdmin", produces = MediaType.APPLICATION_JSON_VALUE)
    public CustomerInfoProjection getAdmin() {
        return adminServices.getAdmin();
    }

    @GetMapping(value = "/getCustomerDetails/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public CustomerInfoProjection getCustomerDetails(@PathVariable Integer customerId) {
        return adminServices.getCustomerDetails(customerId);
    }

    @GetMapping(value = "/manageCustomers/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<CustomerInfoProjection> getCustomers(@PathVariable Integer pageNo, @PathVariable Integer pageSize) {
        return adminServices.manageCustomers(pageNo - 1, pageSize);
    }

    @PutMapping(value = "/deActivateAccount/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String applyDiscount(@PathVariable Integer customerId) {
        return adminServices.deActivateAccount(customerId);
    }

    @PostMapping(value = "/addCampaign", produces = MediaType.APPLICATION_JSON_VALUE)
    public String addCampaign(@Valid @RequestBody Campaign campaign) {
        return adminServices.addCampaign(campaign);
    }
}



