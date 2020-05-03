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
    private CustomerRepository  customerRepository;

    public String saveMyCard(Card card,Integer customerId){
        Customer customer = customerRepository.findByCustomerId(customerId);
        System.out.println(customer.getEmail());

        Card cardExist = paymentRepository.findByCardNo(card.getCardNo());

        if(cardExist!=null){
            if(customer.getCustomerCardList().contains(cardExist))
            customer.getCustomerCardList().add(cardExist);
            return "Card added to card_used_by";
        }

        cardExist = paymentRepository.save(card);
        System.out.println(cardExist.getCardNo());
        customer.getCustomerCardList().add(cardExist);
        System.out.println("eklendi customera");
        cardExist.getCustomerList().add(customer);
        return "New card added";
    }
}
