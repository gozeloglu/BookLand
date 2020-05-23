package com.bookland.demobookland.services;

import com.bookland.demobookland.model.*;
import com.bookland.demobookland.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class PaymentServices {
    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private ShippingCompanyRepository shippingCompanyRepository;

    @Autowired
    private PurchaseDetailRepository purchaseDetailRepository;

    @Autowired
    private CampaignRepository campaignRepository;

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


    public List<ShippingCompany> getCompanies() {
        return shippingCompanyRepository.findAll();
    }


    public double applyCoupon(Map<String, Float> couponCode) {
        Date today = new Date();

        double totalAmount = 0.0;
        String promoCode = null;

        for (String s : couponCode.keySet()) {
            promoCode = s;
            totalAmount = couponCode.get(s);
        }

        Campaign campaign = campaignRepository.findByCouponCode(promoCode);
        if (campaign != null && campaign.getParticipantQuantity() > 0
                && campaign.getEndDate().compareTo(today) > 0
                && (totalAmount * campaign.getCouponDiscount()) / 100 > 0) {
            return (float) totalAmount - ((totalAmount * campaign.getCouponDiscount()) / 100);
        } else {
            System.out.println("Coupon Code is not valid");
        }
        return (float) 0;
    }
}
