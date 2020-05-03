package com.bookland.demobookland.controller;


import com.bookland.demobookland.model.Address;
import com.bookland.demobookland.model.validationGroups.AddAddressGroup;
import com.bookland.demobookland.services.CustomerAddressServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.List;

@RestController
public class CustomerAddressController {

    @Autowired
    private CustomerAddressServices customerAddressServices;

    @Autowired
    private EntityManager em;

    @Transactional
    @PostMapping(value = "/saveAddress/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String saveAddress(@Validated(AddAddressGroup.class) @RequestBody Address address, @PathVariable Integer customerId) {
        return customerAddressServices.CreateAddress(address, customerId);
    }

    @GetMapping(value = "/myAddresses/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Address> showAddresses(@PathVariable Integer customerId) {
        return customerAddressServices.showAddresses(customerId);
    }

    @Transactional
    @PutMapping(value = "/UpdateMyAddress/{customer_id}/{address_id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String updateAddress(@PathVariable Integer customer_id, @PathVariable Integer address_id, @RequestBody Address updatedAddress) {
        return customerAddressServices.updateAddress(customer_id, address_id, updatedAddress);
    }

    @DeleteMapping(value = "/deleteAddress/{customerId}/{addressId}")
    public String deleteBook(@PathVariable Integer customerId, @PathVariable Integer addressId) {
        return customerAddressServices.deleteAddress(customerId, addressId);
    }
}
