package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Card;
import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.repository.CustomerRepository;
import com.bookland.demobookland.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PaymentServices {
    @Autowired
    private PaymentRepository paymentRepository;

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
}
