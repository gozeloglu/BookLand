package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Card;
import com.bookland.demobookland.model.validationGroups.SaveCardGroup;
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
    @PostMapping(value = "/createOrder/{customerId}/{shippingId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String orderCreation(@Validated(SaveCardGroup.class) @RequestBody Card card, @PathVariable Integer customerId,
                           @PathVariable Integer shippingId) {
        if(!paymentServices.saveMyCard(card,customerId)){
            return "Payment Information Failed";
        }
        paymentServices.cargoCreation(shippingId);
        return "orderCreation";
    }
}
