package com.bookland.demobookland.controller;

import com.bookland.demobookland.services.OrderServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OrderController {
    @Autowired
    private OrderServices orderServices;
}
