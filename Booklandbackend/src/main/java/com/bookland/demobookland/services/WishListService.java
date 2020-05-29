package com.bookland.demobookland.services;


import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WishListService {

    @Autowired
    private CustomerRepository customerRepository;

    public Integer inWishList(Integer customerId, Integer bookId){

        Customer customer = customerRepository.findByCustomerId(customerId);

        for(int i = 0; i<customer.getCustomerWishList().size(); i++){
            if(customer.getCustomerWishList().get(i).getBookId().equals(bookId))
                return 1;
        }
        return 0;
    }

}
