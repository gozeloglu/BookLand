package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Order;
import com.bookland.demobookland.model.projections.OrderDetailsProjection;
import com.bookland.demobookland.model.projections.OrderSimpleProjection;
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

    @GetMapping(value = "/myOrders/{pageNo}/{pageSize}/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<OrderSimpleProjection> showMyOrders(@PathVariable Integer pageNo, @PathVariable Integer pageSize, @PathVariable Integer customerId) {

        return orderServices.getMyOrders(pageNo - 1, pageSize, customerId);
    }

    @PostMapping(value = "/createOrder")
    public Order createOrder(@RequestBody Order order) {
        return orderServices.createOrder(order);
    }

    @DeleteMapping(value = "/deleteOrder/{customerId}/{orderId}")
    public String deleteOrder(@PathVariable Integer customerId, @PathVariable Integer orderId) {
        return orderServices.deleteOrder(customerId, orderId);
    }

    @GetMapping(value = "/orderDetails/{orderId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public OrderDetailsProjection orderDetails(@PathVariable Integer orderId) {
        return orderServices.orderDetails(orderId);
    }
}
