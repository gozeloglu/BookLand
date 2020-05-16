package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Order;
import com.bookland.demobookland.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServices {
    @Autowired
    private OrderRepository orderRepository;

    public List<Order> getMyOrders(Integer customerID) {
        return orderRepository.findAllByCustomerId(customerID);
    }

    public Order createOrder(Order order) {
        return orderRepository.save(order);
    }

    public String deleteOrder(Integer customerId, Integer orderId) {
        String response;
        try {
            orderRepository.deleteByCustomerIdAndOrderId(customerId, orderId);
            response = "Order deleted";
            return response;
        } catch (Exception e) {
            response = "Order cannot deleted";
            System.out.println(e);
            return response;
        }
    }
}
