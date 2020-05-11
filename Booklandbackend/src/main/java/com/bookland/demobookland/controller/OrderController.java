package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Order;
import com.bookland.demobookland.services.OrderServices;
import com.bookland.demobookland.services.ShippingServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class OrderController {
    @Autowired
    private OrderServices orderServices;
    @Autowired
    private ShippingServices shippingServices;

    @GetMapping(value = "/myOrders/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Order> showMyOrders(@PathVariable Integer customerId) {
        return orderServices.getMyOrders(customerId);
    }

    @PostMapping(value = "/createOrder")
    public Order createOrder(@RequestBody Order order) {
        return orderServices.createOrder(order);
    }

    @DeleteMapping(value = "/deleteOrder/{customerId}/{orderId}")
    public String deleteOrder(@PathVariable Integer customerId, @PathVariable Integer orderId) {
        return orderServices.deleteOrder(customerId, orderId);
    }
}
