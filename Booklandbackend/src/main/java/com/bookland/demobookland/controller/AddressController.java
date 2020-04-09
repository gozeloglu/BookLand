package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Address;
import com.bookland.demobookland.services.AddressServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import javax.validation.Valid;

@RestController
public class AddressController {
    @Autowired
    private AddressServices addressServices;

    @Autowired
    private EntityManager em;

    @Transactional
    @PostMapping(value = "/saveAddress",produces = MediaType.APPLICATION_JSON_VALUE)
    public String saveAddress(@Valid @RequestBody Address address){

        String result;

        if(addressServices.saveAddress(address)){
            addressServices.saveAddress(address);
            em.persist(address);
            result="Address Successfully Saved";
        }else {
            result="Address could not saved";
        }
        return result;
    }

}
