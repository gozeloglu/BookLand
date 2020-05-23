package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Contains;
import com.bookland.demobookland.model.Order;
import com.bookland.demobookland.model.projections.OrderDetailsProjection;
import com.bookland.demobookland.model.projections.OrderDifferentProjection;
import com.bookland.demobookland.model.projections.OrderSimpleProjection;
import com.bookland.demobookland.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class OrderServices {
    @Autowired
    private OrderRepository orderRepository;

    public List<OrderSimpleProjection> getMyOrders(Integer pageNo, Integer pageSize, Integer customerID) {
        Pageable paging = PageRequest.of(pageNo, pageSize);
        List<OrderSimpleProjection> orderSimpleProjections = new ArrayList<>();

        Page<Order> pagedResult = orderRepository.findByCustomerId(paging, customerID);
        for (Order order : pagedResult.toList()) {
            orderSimpleProjections.add(orderSimpleConverter(order));

        }

        return orderSimpleProjections;
    }

    public OrderSimpleProjection orderSimpleConverter(Order order) {
        return new OrderSimpleProjection() {
            @Override
            public Date getOrderDate() {
                return order.getOrderedTime();
            }

            @Override
            public String getStatus() {
                return order.getContainsList().get(0).getPurchasedDetailedInfo().getStatus();
            }

            @Override
            public Integer getOrderId() {
                return order.getOrderId();
            }

            @Override
            public String getAddressTitle() {
                return order.getAddress().getAddressTitle();
            }

            @Override
            public Float getTotalAmount() {
                return order.getTotalAmount();
            }
        };
    }

    public Order createOrder(Order order) {
        return orderRepository.save(order);
    }

    @Transactional
    public String deleteOrder(Integer customerId, Integer orderId) {
        String response;
        try {
            orderRepository.deleteByCustomerIdAndOrderId(customerId, orderId);
            response = "Order deleted";
            return response;
        } catch (Exception e) {
            response = "Order cannot deleted";
            return response;
        }
    }

    public OrderDetailsProjection orderDetails(Integer orderId) {
        Optional<Order> orderDetails = orderRepository.findById(orderId);
        return OrderConverter(orderDetails.get());
    }

    public OrderDetailsProjection OrderConverter(Order order) {
        return new OrderDetailsProjection() {
            @Override
            public Date getOrderedTime() {
                return order.getOrderedTime();
            }

            @Override
            public String getAddressLine() {
                return order.getAddress().getAddressLine();
            }

            @Override
            public String getCity() {
                return order.getAddress().getPostalCodeCity().getCity().getCity();
            }

            @Override
            public String getCountry() {
                return order.getAddress().getPostalCodeCity().getCity().getCountry();
            }

            @Override
            public String getStatus() {
                return order.getContainsList().get(0).getPurchasedDetailedInfo().getStatus();
            }

            @Override
            public String getCompanyName() {
                return order.getContainsList().get(0).getPurchasedDetailedInfo().getShippingCompany().getCompanyName();
            }

            @Override
            public List<OrderDifferentProjection> getDifference() {
                return ordersDetails(order);
            }

            @Override
            public Float getTotalAmount() {
                return order.getTotalAmount();
            }
        };
    }

    public OrderDifferentProjection convert(Contains contains) {
        return new OrderDifferentProjection() {
            @Override
            public Float getPrice() {
                return contains.getBook().getPriceList().get(contains.getBook().getPriceList().size() - 1).getPrice() * contains.getQuantity();
            }

            @Override
            public Integer getQuantity() {
                return contains.getQuantity();
            }

            @Override
            public String getBookName() {
                return contains.getBook().getBookName();
            }

            @Override
            public String getAuthor() {
                return contains.getBook().getAuthor();
            }

            @Override
            public String getBookImage() {
                return contains.getBook().getBookImage();
            }

            @Override
            public Integer getTrackingNumber() {
                return contains.getTrackingNumber();
            }
        };
    }

    public List<OrderDifferentProjection> ordersDetails(Order order) {
        List<OrderDifferentProjection> orders = new ArrayList<>();
        List<Contains> contains = order.getContainsList();

        for (Contains contains1 : contains) {
            orders.add(convert(contains1));
        }
        return orders;
    }

    public Long getCustomerOrderCount(Integer customerId) {
        return (long)orderRepository.findAllByCustomerId(customerId).size();
    }
}
