package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Campaign;
import com.bookland.demobookland.model.Contains;
import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.Order;
import com.bookland.demobookland.model.projections.CustomerInfoProjection;
import com.bookland.demobookland.model.projections.OrderAdminSimpleProjection;
import com.bookland.demobookland.model.projections.OrderDetailAdminProjection;
import com.bookland.demobookland.model.projections.OrderDifferentProjection;
import com.bookland.demobookland.repository.CampaignRepository;
import com.bookland.demobookland.repository.CustomerRepository;
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
        Page<Order> pagedResult = orderRepository.findAllByOrderByOrderedTimeDesc(paging);
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
}



