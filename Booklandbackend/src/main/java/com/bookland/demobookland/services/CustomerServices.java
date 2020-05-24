package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.model.Comment;
import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.LoginInterface;
import com.bookland.demobookland.repository.BookRepository;
import com.bookland.demobookland.repository.CommentRepository;
import com.bookland.demobookland.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.security.auth.login.LoginException;
import javax.transaction.Transactional;
import java.util.Optional;

@Service

public class CustomerServices {
    /*Injection of repository*/
    @Autowired
    private PasswordEncoder encoder;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private CommentRepository commentRepository;

    /*Saving the registered customer to the database and return the id of the new customer*/
    @Transactional
    public Integer saveCustomer(Customer customer) {
        Customer existingCustomer = customerRepository.findByEmail(customer.getEmail());
        if (existingCustomer == null) {
            String encodedPassword = new BCryptPasswordEncoder().encode(customer.getPassword());
            customer.setPassword(encodedPassword);
            customerRepository.save(customer);
            return customer.getCustomerId();
        } else {
            return 0;
        }
    }


    /*Returns existing customer id if login is successful*/
    public LoginInterface getLogin(Customer customer) throws LoginException {
        LoginInterface loginUser = customerRepository.findAllByEmail(customer.getEmail());
        Customer customer1 = customerRepository.findByEmail(customer.getEmail());
        if (loginUser != null) {
            if (customer1 != null && customer1.getStatus() != 0) {
                if (encoder.matches(customer.getPassword(), loginUser.getPassword())) {
                    return loginUser;
                } else {
                    throw new LoginException("Password or Username is incorrect");
                }
            } else {
                throw new LoginException("User Deactivated");
            }
        } else {
            throw new LoginException("User not found");
        }

    }

    public Comment comment(Integer bookId, Integer customerId, Comment comment) {
        comment.setBookId(bookId);
        comment.setCustomerId(customerId);
        return commentRepository.save(comment);
    }

    public Customer updateCustomer(Customer customer, Integer customerId) throws LoginException {
        try {
            Customer currentCustomer = customerRepository.findByCustomerId(customerId);
            if (customer.getFirstName() != null) {
                currentCustomer.setFirstName(customer.getFirstName());
            }
            if (customer.getSurname() != null) {
                currentCustomer.setSurname(customer.getSurname());
            }
            if (customer.getDateOfBirth() != null) {
                System.out.println(customer.getDateOfBirth());
                currentCustomer.setDateOfBirth(customer.getDateOfBirth());
            }
            if (customer.getPhoneNumber() != null) {
                currentCustomer.setPhoneNumber(customer.getPhoneNumber());
            }
            if (customer.getEmail() != null) {
                Customer existingCustomer = customerRepository.findByEmail(customer.getEmail());
                if (existingCustomer == null) {
                    currentCustomer.setEmail(customer.getEmail());
                } else {
                    throw new LoginException("Email already exist");
                }
            }
            return customerRepository.save(currentCustomer);
        } catch (Exception e) {
            return null;
        }
    }

    @Transactional
    public Integer addWishList(Integer customerId, Integer isbn) {
        Customer customer = customerRepository.findByCustomerId(customerId);
        boolean inWishList = false;

        if (customer.getCustomerWishList().size() == 0) {
            Optional<Book> book = bookRepository.findById(isbn);
            customer.getCustomerWishList().add(book.get());
            inWishList = true;
        } else {
            for (int i = 0; i < customer.getCustomerWishList().size(); i++) {
                if (!customer.getCustomerWishList().get(i).getBookId().equals(isbn)) {
                    Optional<Book> book = bookRepository.findById(isbn);
                    if (book.isPresent()) {
                        customer.getCustomerWishList().add(book.get());
                        inWishList = true;
                        break;
                    }
                }
            }
        }
        customerRepository.save(customer);
        if (inWishList) {
            return 1;
        } else return 0;
    }

    @Transactional
    public Integer removeWishList(Integer customerId, Integer isbn) {
        Customer customer = customerRepository.findByCustomerId(customerId);
        boolean inWishList = true;
        for (int i = 0; i < customer.getCustomerWishList().size(); i++) {
            if (customer.getCustomerWishList().get(i).getBookId().equals(isbn)) {
                Optional<Book> book = bookRepository.findById(isbn);
                if (book.isPresent()) {
                    customer.getCustomerWishList().remove(book.get());
                    customerRepository.save(customer);
                    inWishList = false;
                    break;
                }
            }
        }
        if (!inWishList) /*wishlist den remove olursa 1 dönüyo*/
            return 1;
        else return 0;
    }
}
