package com.bookland.demobookland.services;

import com.bookland.demobookland.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderServices {
    @Autowired
    private OrderRepository orderRepository;

}
