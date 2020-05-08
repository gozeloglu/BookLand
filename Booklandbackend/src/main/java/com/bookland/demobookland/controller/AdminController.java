package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.projections.CustomerInfoProjection;
import com.bookland.demobookland.services.AdminServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AdminController {

    @Autowired
    private AdminServices adminServices;

    @GetMapping(value = "/getAdmin", produces = MediaType.APPLICATION_JSON_VALUE)
    public CustomerInfoProjection getAdmin() {
        return adminServices.getAdmin();
    }


}



