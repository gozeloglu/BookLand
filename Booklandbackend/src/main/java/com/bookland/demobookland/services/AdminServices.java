package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.CustomerInfoProjection;
import com.bookland.demobookland.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AdminServices {

    @Autowired
    private CustomerRepository customerRepository;

    public CustomerInfoProjection getAdmin() {
        return customerRepository.findByIsAdminEquals(1);
    }

    public List<CustomerInfoProjection> manageCustomers(Integer pageNo, Integer pageSize) {
        Pageable paging = PageRequest.of(pageNo, pageSize);

        Page<CustomerInfoProjection> pagedResult = customerRepository.findAllProjectedBy(paging);
        return pagedResult.toList();
    }

    public String deActivateAccount(Integer customerId) {
        try {
            Optional<Customer> customer = customerRepository.findById(customerId);
            if(customer.isPresent()){
                Customer existingCustomer = customer.get();
                existingCustomer.setStatus(0);
                customerRepository.save(existingCustomer);
                return "Account Deactivated";
            }else {
                return "User Not Found";
            }
        } catch (Exception e) {
            System.out.println(e);
            return "Some Problem Occured";
        }

    }
}



