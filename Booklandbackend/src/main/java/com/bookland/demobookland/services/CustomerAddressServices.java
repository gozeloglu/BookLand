package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Address;
import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.PostalCodeCity;
import com.bookland.demobookland.repository.AddressRepository;
import com.bookland.demobookland.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.List;


@Service
public class CustomerAddressServices {


    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private EntityManager em;

    @Transactional
    public String CreateAddress(Address customerAddress, Integer customerId) {
        try {
            addressRepository.save(customerAddress);
            em.persist(customerAddress.getPostalCodeCity());
            em.persist(customerAddress.getPostalCodeCity().getCity());
            Customer current_customer = customerRepository.findByCustomerId(customerId);
            current_customer.getCustomerAddressList().add(customerAddress);
            return "Address saved";
        } catch (Exception e) {
            return "Address could'nt saved";
        }
    }

    public List<Address> showAddresses(int id) {
        return customerRepository.findByCustomerId(id).getCustomerAddressList();
    }

    @Transactional
    public String updateAddress(Integer customer_id, Integer address_id, Address address) {
        PostalCodeCity postalCodeCity = new PostalCodeCity();
        try {

            List<Address> addressList = customerRepository.findByCustomerId(customer_id).getCustomerAddressList();
            for (Address currentAddress : addressList) {
                if (currentAddress.getAddressId() == address_id) {
                    if (address.getAddressLine() != null) {
                        currentAddress.setAddressLine(address.getAddressLine());
                    }
                    if (address.getAddressTitle() != null) {
                        currentAddress.setAddressTitle(address.getAddressTitle());
                    }
                    if (address.getPostalCodeCity().getPostalCode() != null) {
                        if (!address.getPostalCodeCity().getPostalCode().equals(currentAddress.getPostalCodeCity().getPostalCode())) {
                            postalCodeCity.setPostalCode(address.getPostalCodeCity().getPostalCode());
                        } else {
                            postalCodeCity.setPostalCode(currentAddress.getPostalCodeCity().getPostalCode());
                        }
                        if (address.getPostalCodeCity().getCity().getCity() != null) {
                            if (!address.getPostalCodeCity().getCity().getCity().equals(currentAddress.getPostalCodeCity().getCity().getCity())) {
                                postalCodeCity.setCity(address.getPostalCodeCity().getCity());
                            } else {
                                postalCodeCity.setCity(currentAddress.getPostalCodeCity().getCity());
                            }
                            if (address.getPostalCodeCity().getCity().getCountry() != null) {
                                currentAddress.getPostalCodeCity().getCity().setCountry(address.getPostalCodeCity().getCity().getCountry());
                            } else {
                                postalCodeCity.getCity().setCountry(currentAddress.getPostalCodeCity().getCity().getCountry());
                            }
                        }
                        currentAddress.setPostalCodeCity(postalCodeCity);
                        addressRepository.save(currentAddress);
                        em.persist(currentAddress);
                    }
                    break;
                }
            }
            return "Address Updated";
        } catch (Exception e) {
            System.out.println(e);
            return "Address cannot updated";

        }
    }

    @Transactional
    public String deleteAddress(Integer customerId, Integer addressId) {
        String response;
        try {
            List<Address> addressList = customerRepository.findByCustomerId(customerId).getCustomerAddressList();
            for (Address address : addressList) {
                if (address.getAddressId() == addressId) {
                    addressList.remove(address);
                    break;
                }
            }
            response = "Address deleted";
            return response;
        } catch (Exception e) {
            response = "Address cannot be deleted";
            return response;
        }
    }

}
