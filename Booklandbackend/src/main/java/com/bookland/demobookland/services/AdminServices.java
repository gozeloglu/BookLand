package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Campaign;
import com.bookland.demobookland.model.Contains;
import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.Order;
import com.bookland.demobookland.model.projections.*;
import com.bookland.demobookland.repository.CampaignRepository;
import com.bookland.demobookland.repository.CustomerRepository;
import com.bookland.demobookland.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;

@Service
public class AdminServices {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CampaignRepository campaignRepository;

    @Autowired
    private OrderRepository orderRepository;

    public CustomerInfoProjection getAdmin() {
        return customerRepository.findByIsAdminEquals(1);
    }

    public CustomerInfoProjection getCustomerDetails(Integer customerId) {
        Optional<Customer> customer = customerRepository.findById(customerId);
        if (customer.isPresent()) {
            Customer existingCustomer = customer.get();
            return new CustomerInfoProjection() {
                @Override
                public String getFirstName() {
                    return existingCustomer.getFirstName();
                }

                @Override
                public String getSurname() {
                    return existingCustomer.getSurname();
                }

                @Override
                public String getPhoneNumber() {
                    return existingCustomer.getPhoneNumber();
                }

                @Override
                public Date getDateOfBirth() {
                    return existingCustomer.getDateOfBirth();
                }

                @Override
                public String getCustomerId() {
                    return String.valueOf(existingCustomer.getCustomerId());
                }

                @Override
                public String getEmail() {
                    return existingCustomer.getEmail();
                }

                @Override
                public Integer getStatus() {
                    return existingCustomer.getStatus();
                }

            };
        }
        return null;

    }


    public List<CustomerInfoProjection> manageCustomers(Integer pageNo, Integer pageSize) {
        Pageable paging = PageRequest.of(pageNo, pageSize);

        Page<CustomerInfoProjection> pagedResult = customerRepository.findAllProjectedBy(paging);
        return pagedResult.toList();
    }

    @Transactional
    public String deActivateAccount(Integer customerId) {
        try {
            Optional<Customer> customer = customerRepository.findById(customerId);
            if (customer.isPresent()) {
                Customer existingCustomer = customer.get();
                existingCustomer.setStatus(0);
                customerRepository.save(existingCustomer);
                return "Account Deactivated";
            } else {
                return "User Not Found";
            }
        } catch (Exception e) {
            return "Some Problem Occured";
        }

    }

    @Transactional
    public String activateAccount(Integer customerId) {
        try {
            Optional<Customer> customer = customerRepository.findById(customerId);
            if (customer.isPresent()) {
                Customer existingCustomer = customer.get();
                existingCustomer.setStatus(1);
                customerRepository.save(existingCustomer);
                return "Account Activated";
            } else {
                return "User Not Found";
            }
        } catch (Exception e) {
            return "Some Problem Occured";
        }

    }

    @Transactional
    public String addCampaign(Campaign campaign) {
        campaignRepository.save(campaign);
        return "Campaign created";
    }

    public OrderDetailAdminProjection showDetailOrderAdmin(Integer orderId) {
        Optional<Order> order = orderRepository.findById(orderId);
        return showOrderDetailsAdmin(order.get());
    }

    public OrderDetailAdminProjection showOrderDetailsAdmin(Order order) {
        return new OrderDetailAdminProjection() {
            @Override
            public String getCardNo() {
                return order.getCardNo();
            }

            @Override
            public Integer getOrderId() {
                return order.getOrderId();
            }

            @Override
            public Date getOrderedTime() {
                return order.getOrderedTime();
            }

            @Override
            public String getFirstName() {
                return order.getCustomerOrder().getFirstName();
            }

            @Override
            public String getSurname() {
                return order.getCustomerOrder().getSurname();
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
            public String getCoupon() {
                if (order.getCampaign() == null)
                    return "No Coupon";
                else return order.getCampaign().getCouponCode();
            }

            @Override
            public Integer getCustomerId() {
                return order.getCustomerId();
            }

            @Override
            public List<OrderDifferentProjection> getDifference() {
                return differentPartConverter(order);
            }

            @Override
            public Float getTotalAmount() {
                return order.getTotalAmount();
            }

            @Override
            public Float getShippingPrice() {
                return order.getContainsList().get(0).getPurchasedDetailedInfo().getShippingCompany().getShippingPrice();
            }
        };
    }

    public List<OrderDifferentProjection> differentPartConverter(Order order) {
        List<OrderDifferentProjection> orders = new ArrayList<>();
        List<Contains> contains = order.getContainsList();

        for (Contains contains1 : contains) {
            orders.add(convert(contains1));
        }
        return orders;
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

    public List<OrderAdminSimpleProjection> showAllOrdersAdmin(Integer pageNo, Integer pageSize) {
        Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<Order> pagedResult = orderRepository.findAllByOrderByOrderedTimeDescOrderIdDesc(paging);
        List<OrderAdminSimpleProjection> result = new ArrayList<>();

        for (Order o : pagedResult.toList()) {
            result.add(orderAdminSimpleProjection(o));
        }
        return result;
    }

    public OrderAdminSimpleProjection orderAdminSimpleProjection(Order orders) {
        return new OrderAdminSimpleProjection() {
            @Override
            public Float getTotalAmount() {
                return orders.getTotalAmount();
            }

            @Override
            public Integer getOrderId() {
                return orders.getOrderId();
            }

            @Override
            public String getStatus() {
                return orders.getContainsList().get(0).getPurchasedDetailedInfo().getStatus();
            }

            @Override
            public String getCustomerName() {
                return orders.getCustomerOrder().getFirstName();
            }

            @Override
            public String getCustomerSurname() {
                return orders.getCustomerOrder().getSurname();
            }

            @Override
            public Date getOrderedDate() {
                return orders.getOrderedTime();
            }
        };
    }

    public Long getOrderCountTotal() {
        return orderRepository.count();
    }

    public Integer confirmOrder(Integer orderId) {
        Optional<Order> order = orderRepository.findById(orderId);
        Order currentOrder = order.get();
        boolean stock = true;

        for (Contains c : currentOrder.getContainsList()) {
            if (c.getBook().getQuantity() < c.getQuantity()) {
                stock = false;
                break;
            }
        }
        if (changeStatusOrder(currentOrder, stock))
            return 1;
        else
            return 0;
    }

    @Transactional
    public boolean changeStatusOrder(Order order, boolean stock) {
        Date dt = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(dt);
        calendar.add(Calendar.DATE, 1);
        dt = calendar.getTime();

        if (stock) {
            for (Contains c : order.getContainsList()) {
                c.getPurchasedDetailedInfo().setStatus("Shipped");
                c.getBook().setQuantity(c.getBook().getQuantity() - c.getQuantity());
                c.getPurchasedDetailedInfo().setReleasedTime(dt);
            }
        } else {
            for (Contains c : order.getContainsList()) {
                c.getPurchasedDetailedInfo().setStatus("Cancelled");
            }
        }
        orderRepository.save(order);
        return stock;
    }

    @Transactional
    public Integer rejectOrder(Integer orderId) {
        Optional<Order> order = orderRepository.findById(orderId);
        Order currentOrder = order.get();
        boolean isValid = false;

        for (Contains c : currentOrder.getContainsList()) {
            if (c.getPurchasedDetailedInfo().getStatus().equals("Shipped") || c.getPurchasedDetailedInfo().getStatus().equals("Delivered")) {
            } else {
                c.getPurchasedDetailedInfo().setStatus("Cancelled");
                isValid = true;
            }
        }
        orderRepository.save(currentOrder);
        if (isValid)
            return 1;
        return 0;
    }

    public Long getCustomerCount() {
        return customerRepository.count();
    }

    public List<UserSearchProjection> getCustomerBySearchCriteria(Integer pageNo, Integer pageSize, String keyword) {
        try {
            Integer customerId = Integer.parseInt(keyword);
            Pageable paging = PageRequest.of(pageNo, pageSize);
            Page<UserSearchProjection> pagedResult = customerRepository.findByCustomerId(paging, customerId);

            return pagedResult.toList();
        } catch (Exception e) {
            Pageable paging = PageRequest.of(pageNo, pageSize);
            Page<UserSearchProjection> pagedResult = customerRepository.findByFirstNameContainsOrSurnameContainsOrEmailContains(paging, keyword, keyword, keyword);

            return pagedResult.toList();
        }

    }

    public Long getCustomerCountBySearchCriteria(String keyword) {
        try {
            Integer customerId = Integer.parseInt(keyword);
            List<UserSearchProjection> result = customerRepository.findAllByCustomerId(customerId);

            return (long) result.size();
        } catch (Exception e) {
            List<UserSearchProjection> result = customerRepository.findByFirstNameContainsOrSurnameContainsOrEmailContains(keyword, keyword, keyword);
            return (long) result.size();
        }

    }
}



