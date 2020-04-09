package com.bookland.demobookland.controller;


import com.bookland.demobookland.model.Address;
import com.bookland.demobookland.model.CustomerAddress;
import com.bookland.demobookland.services.CustomerAddressServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@RestController
public class CustomerAddressController {

    @Autowired
    private CustomerAddressServices customerAddressServices;

    @Autowired
    private EntityManager em;

    @Transactional
    @PostMapping(value = "/saveCustomerAddress", produces = MediaType.APPLICATION_JSON_VALUE)
    public String saveAddress(@Valid @RequestBody CustomerAddress customerAddress) {
        String result = "";
        try {
            if (customerAddressServices.CreateCustomerAddress(customerAddress)) {
                customerAddressServices.CreateCustomerAddress(customerAddress);
                em.persist(customerAddress);
                result = "Address Saved";
            }
            ;
        } catch (Exception e) {
            result = "Address is not saved";
        }
        return result;
    }


    /*This function returns the customer information with address but we already have the customer info because
     * we've given customerID to process the query*/

   /* @GetMapping(value = "/myAddresses",produces = MediaType.APPLICATION_JSON_VALUE)
    public List<CustomerAddress> showAddresses(@RequestParam String id){
        return customerAddressServices.showAddresses(Integer.parseInt(id));
    }*/


    @GetMapping(value = "/myAddresses", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Address> showAddresses(@RequestParam String id) {
        List<CustomerAddress> customerAddresses;
        List<Address> Addresses = new ArrayList<>();

        customerAddresses = customerAddressServices.showAddresses(Integer.parseInt(id));
        for (CustomerAddress customerAddress1 : customerAddresses) {
            Address address = new Address();
            address.setAddressId(customerAddress1.getAddress().getAddressId());
            address.setAddressLine(customerAddress1.getAddress().getAddressLine());
            address.setAddressTitle(customerAddress1.getAddress().getAddressTitle());
            address.setPostalCodeCity(customerAddress1.getAddress().getPostalCodeCity());
            Addresses.add(address);
        }
        return Addresses;
    }


}
