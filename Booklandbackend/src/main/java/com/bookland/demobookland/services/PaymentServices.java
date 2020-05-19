package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Card;
import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.PurchasedDetailedInfo;
import com.bookland.demobookland.model.ShippingCompany;
import com.bookland.demobookland.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class PaymentServices {
    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private ShippingCompanyRepository shippingCompanyRepository;

    @Autowired
    private PurchaseDetailRepository purchaseDetailRepository;

    /*@Autowired
    private ContainsRepository containsRepository;*/

    @Autowired
    private CustomerRepository customerRepository;

    public String saveMyCard(Card card, Integer customerId) {
        Customer customer = customerRepository.findByCustomerId(customerId);

        Card cardExist = paymentRepository.findByCardNo(card.getCardNo());

        if (cardExist != null) {
            if (customer.getCustomerCardList().contains(cardExist))
                return "Card is already in used";
            customer.getCustomerCardList().add(cardExist);
            return "Card added to card_used_by";
        }

        cardExist = paymentRepository.save(card);
        customer.getCustomerCardList().add(cardExist);
        cardExist.getCustomerCardList().add(customer);
        return "New card added";
    }

    public void cargoCreation(Integer shippingId){
        PurchasedDetailedInfo purchasedDetailedInfo = new PurchasedDetailedInfo();
        purchasedDetailedInfo.setShippingCompanyId(shippingId);
    }


}
