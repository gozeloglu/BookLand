package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Address;
import com.bookland.demobookland.model.Card;
import com.bookland.demobookland.model.validationGroups.AddAddressGroup;
import com.bookland.demobookland.services.PaymentServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.transaction.Transactional;

@RestController
public class PaymentController {
    @Autowired
    private PaymentServices paymentServices;

    @Transactional
    @PostMapping(value = "/saveCard/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String saveCard(@Validated(AddAddressGroup.class) @RequestBody Card card, @PathVariable Integer customerId){
        return paymentServices.saveMyCard(card,customerId);
    }
}
