package com.bookland.demobookland.controller;


import com.bookland.demobookland.model.Address;
import com.bookland.demobookland.model.CustomerAddress;
import com.bookland.demobookland.model.validationGroups.AddAddressGroup;
import com.bookland.demobookland.services.CustomerAddressServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@RestController
public class CustomerAddressController {

    @Autowired
    private CustomerAddressServices customerAddressServices;

    @Autowired
    private EntityManager em;

    @Transactional
    @PostMapping(value = "/saveAddress/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String saveAddress(@Validated(AddAddressGroup.class) @RequestBody Address address, @PathVariable Integer customerId){
        return customerAddressServices.CreateAddress(address,customerId);
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

    @Transactional
    @PutMapping(value = "/UpdateMyAddress/{customer_id}/{address_id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public Address updateAddress(@PathVariable Integer customer_id, @PathVariable Integer address_id,@RequestBody Address updatedAddress) {
        return customerAddressServices.updateAddress(customer_id, address_id, updatedAddress);
    }


}
