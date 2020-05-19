package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Card;
import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.PurchasedDetailedInfo;
import com.bookland.demobookland.repository.CustomerRepository;
import com.bookland.demobookland.repository.PaymentRepository;
import com.bookland.demobookland.repository.PurchaseDetailRepository;
import com.bookland.demobookland.repository.ShippingCompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    public Boolean saveMyCard(Card card, Integer customerId) {
        Customer customer = customerRepository.findByCustomerId(customerId);

        Card cardExist = paymentRepository.findByCardNo(card.getCardNo());

        if (cardExist != null) {
            if (!card.getOwnerName().equals(cardExist.getOwnerName()) || !card.getOwnerSurname().equals(cardExist.getOwnerSurname()))
                return false;
            if (customer.getCustomerCardList().contains(cardExist))
                return true;
            customer.getCustomerCardList().add(cardExist);
            return true;
        }

        cardExist = paymentRepository.save(card);
        customer.getCustomerCardList().add(cardExist);
        cardExist.getCustomerCardList().add(customer);
        return true;
    }

    public void cargoCreation(Integer shippingId) {
        PurchasedDetailedInfo purchasedDetailedInfo = new PurchasedDetailedInfo();
        purchasedDetailedInfo.setShippingCompanyId(shippingId);
        purchaseDetailRepository.save(purchasedDetailedInfo);
    }


}
