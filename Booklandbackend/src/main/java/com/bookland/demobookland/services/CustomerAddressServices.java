package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Address;
import com.bookland.demobookland.model.CustomerAddress;
import com.bookland.demobookland.model.PostalCodeCity;
import com.bookland.demobookland.repository.CustomerAddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.List;


@Service
public class CustomerAddressServices {

    @Autowired/*Injection of repository*/
    private CustomerAddressRepository customerAddressRepository;

    @Autowired
    private EntityManager em;

    @Transactional
    public Boolean CreateCustomerAddress(CustomerAddress customerAddress) {
        try {
            customerAddressRepository.save(customerAddress);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<CustomerAddress> showAddresses(int id) {
        return customerAddressRepository.findByCustomerId(id);
    }

    @Transactional
    public Address updateAddress(Integer customer_id, Integer address_id, Address address) {
        CustomerAddress currentAddress = customerAddressRepository.findByCustomerIdAndAddressId(customer_id, address_id);
        PostalCodeCity postalCodeCity = new PostalCodeCity();
        try {

            if (address.getAddressLine() != null) {
                currentAddress.getAddress().setAddressLine(address.getAddressLine());
            }
            if (address.getAddressTitle() != null) {
                currentAddress.getAddress().setAddressTitle(address.getAddressTitle());
            }
            if (address.getPostalCodeCity() != null) {
                if (address.getPostalCodeCity().getPostalCode() != null) {
                    //System.out.println("postal code null değil");
                    if (!address.getPostalCodeCity().getPostalCode().equals(currentAddress.getAddress().getPostalCodeCity().getPostalCode())) {
                        //System.out.println("postal code farklı");
                        postalCodeCity.setPostalCode(address.getPostalCodeCity().getPostalCode());
                        //System.out.println(postalCodeCity.getPostalCode());
                    } else {
                        postalCodeCity.setPostalCode(currentAddress.getAddress().getPostalCodeCity().getPostalCode());
                    }
                    if (address.getPostalCodeCity().getCity() != null) {
                        //System.out.println("city null değil");

                        if (!address.getPostalCodeCity().getCity().getCity().equals(currentAddress.getAddress().getPostalCodeCity().getCity().getCity())) {
                            // System.out.println("city farklı");
                            postalCodeCity.setCity(address.getPostalCodeCity().getCity());
                            System.out.println(postalCodeCity.getCity().getCity());
                        } else {
                            postalCodeCity.setCity(currentAddress.getAddress().getPostalCodeCity().getCity());
                        }
                        if (address.getPostalCodeCity().getCity().getCountry() != null) {
                            currentAddress.getAddress().getPostalCodeCity().getCity().setCountry(address.getPostalCodeCity().getCity().getCountry());
                        } else {
                            postalCodeCity.getCity().setCountry(currentAddress.getAddress().getPostalCodeCity().getCity().getCountry());
                        }
                    } else {
                        //System.out.println("city null");
                        postalCodeCity.setCity(currentAddress.getAddress().getPostalCodeCity().getCity());
                    }

                }

                currentAddress.getAddress().setPostalCodeCity(postalCodeCity);
            }
            customerAddressRepository.save(currentAddress);
            em.persist(currentAddress);
        } catch (Exception e) {
            System.out.println(e);
        }
        return currentAddress.getAddress();

    }


}
