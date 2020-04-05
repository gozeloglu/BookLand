package com.bookland.demobookland.controller;
import com.bookland.demobookland.model.Admin;
import com.bookland.demobookland.services.AdminServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AdminController {
    @Autowired
    private AdminServices adminServices;

    @GetMapping(value = "/getAdmin",produces = MediaType.APPLICATION_JSON_VALUE)
    public Admin getAdmin(){
        return adminServices.getAdmin();
    }

    @PostMapping(value = "/messageAdmin")
    public String messageAdmin(@RequestBody String s){
        return String.format("%s",s);
    }

    @PostMapping(value = "/saveAdmin")
    public Admin saveAdmin(@RequestBody Admin  admin){
        return adminServices.saveAdmin(admin);
    }

}



