package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.projections.OrderDetailsProjection;
import com.bookland.demobookland.model.projections.OrderSimpleProjection;
import com.bookland.demobookland.services.OrderServices;
import com.bookland.demobookland.services.ShippingServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class OrderController {
    @Autowired
    private OrderServices orderServices;

    @GetMapping(value = "/myOrders/{pageNo}/{pageSize}/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<OrderSimpleProjection> showMyOrders(@PathVariable Integer pageNo, @PathVariable Integer pageSize, @PathVariable Integer customerId) {
        return orderServices.getMyOrders(pageNo - 1, pageSize, customerId);
    }

    @GetMapping(value = "/getCustomerOrderCount/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public Long getCustomerOrderCount(@PathVariable Integer customerId) {
        return orderServices.getCustomerOrderCount(customerId);
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
