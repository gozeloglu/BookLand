package com.bookland.demobookland.services;


import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.Price;
import com.bookland.demobookland.model.projections.WishListProjection;
import com.bookland.demobookland.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class WishListService {

    @Autowired
    private CustomerRepository customerRepository;

    public Integer inWishList(Integer customerId, Integer bookId) {

        Customer customer = customerRepository.findByCustomerId(customerId);

        for (int i = 0; i < customer.getCustomerWishList().size(); i++) {
            if (customer.getCustomerWishList().get(i).getBookId().equals(bookId))
                return 1;
        }
        return 0;
    }

    public List<WishListProjection> myWishList(Integer pageNo, Integer pageSize, Integer customerId) {
        Customer customer = customerRepository.findByCustomerId(customerId);
        int start_index = pageNo * pageSize;
        int end_index = ((pageNo + 1) * pageSize);
        List<WishListProjection> finalWishList = new ArrayList<>();

        for (int i = 0; i < customer.getCustomerWishList().size(); i++) {
            finalWishList.add(wishListConverter(customer.getCustomerWishList().get(i)));
        }

        if (finalWishList.size() == 0) {
            return new ArrayList<>();
        } else {
            if (finalWishList.size() >= start_index) {
                if (finalWishList.size() >= end_index)
                    return finalWishList.subList(start_index, end_index);
                else
                    return finalWishList.subList(start_index, finalWishList.size());
            }
        }

        return new ArrayList<>();
    }

    public WishListProjection wishListConverter(Book book) {
        return new WishListProjection() {
            @Override
            public String getBookName() {
                return book.getBookName();
            }

            @Override
            public Integer getBookId() {
                return book.getBookId();
            }

            @Override
            public String getAuthor() {
                return book.getAuthor();
            }

            @Override
            public String getBookImage() {
                return book.getBookImage();
            }

            @Override
            public List<Price> getPriceList() {
                return book.getPriceList();
            }

            @Override
            public Integer getInDiscount() {
                return book.getInDiscount();
            }

        };
    }

}
