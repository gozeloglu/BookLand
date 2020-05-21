package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Book;
import com.bookland.demobookland.model.Price;
import com.bookland.demobookland.model.SearchCriteria.BookSpecification;
import com.bookland.demobookland.model.SearchCriteria.SearchCriteria;
import com.bookland.demobookland.model.SearchCriteria.SearchOperation;
import com.bookland.demobookland.model.projections.BookDetailsProjection;
import com.bookland.demobookland.model.projections.ExplorePageProjection;
import com.bookland.demobookland.repository.BookRepository;
import com.bookland.demobookland.repository.PriceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class BookServices {

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private PriceRepository priceRepository;

    public List<ExplorePageProjection> getAllBooks(Integer pageNo, Integer pageSize) {
        Pageable paging = PageRequest.of(pageNo, pageSize);

        Page<ExplorePageProjection> pagedResult = bookRepository.findAllProjectedBy(paging);
        return pagedResult.toList();
    }

    // TODO Try other time
    /*public Page<ExplorePageProjection> getAllBooks(Integer pageNo, Integer pageSize) {
        Pageable paging = PageRequest.of(pageNo, pageSize);

        Page<ExplorePageProjection> pagedResult = bookRepository.findAllProjectedBy(paging);
        //System.out.println(pagedResult.get().map());
        return pagedResult;
    }*/

    /* Add operation for book*/
    @Transactional
    public String addBook(Book book) {
        String response;
        try {
            bookRepository.save(book);

            /*If admin is going to add books without the price if-else is going to add*/
            Price newPrice = new Price();
            newPrice.setISBN(book.getBookId());
            newPrice.setPrice(book.getPriceList().get(0).getPrice());
            priceRepository.save(newPrice);
            response = "Book added";
            return response;
        } catch (Exception e) {
            response = " Book could not added.";
            return response;
        }

    }

    /* Delete operation for book*/

    @Transactional
    public void deleteBook(int id) {
        bookRepository.deleteById(id);
    }

    /* Update operations for book*/

    @Transactional
    public String updateBook(Integer id, Book book) {
        String response;
        try {
            Optional<Book> optionalBook = bookRepository.findById(id);
            Book current_book = optionalBook.get();
            if (book.getRealIsbn() != null) {
                current_book.setRealIsbn(book.getRealIsbn());
            }

            if (book.getAuthor() != null) {
                current_book.setAuthor(book.getAuthor());
            }

            if (book.getBookName() != null) {
                current_book.setBookName(book.getBookName());
            }

            if (book.getCategory() != null) {
                current_book.setCategory(book.getCategory());
            }

            if (book.getSubCategory() != null) {
                current_book.setSubCategory(book.getSubCategory());
            }

            if (book.getInHotList() != null) {
                current_book.setInHotList(book.getInHotList());
            }

            if (book.getDescription() != null) {
                current_book.setDescription(book.getDescription());
            }

            if (book.getBookImage() != null) {
                current_book.setBookImage(book.getBookImage());
            }

            if (book.getQuantity() != null) {
                current_book.setQuantity(book.getQuantity());
            }
            if (book.getPriceList() != null) {
                if (book.getPriceList().get(0).getPrice() != null) {
                    current_book.setInDiscount(0);
                    Price newPrice = new Price();
                    newPrice.setISBN(current_book.getBookId());
                    newPrice.setPrice(book.getPriceList().get(0).getPrice());
                    priceRepository.save(newPrice);
                }
            }
            bookRepository.save(current_book);
            response = "Book Properties Updated";
            return response;
        } catch (Exception e) {
            response = "Book cannot updated";
            return response;
        }

    }

    /*Get distinct categories*/

    public List<String> getCategory() {
        return bookRepository.findDistinctByCategory();
    }

    public List<ExplorePageProjection> getBookByCategory(Integer pageNo, Integer pageSize, String category) {
        Pageable paging = PageRequest.of(pageNo, pageSize);

        Page<ExplorePageProjection> pagedResult = bookRepository.findByCategoryEquals(paging, category);
        return pagedResult.toList();
    }

    public Long getBookCount() {
        return bookRepository.count();
    }

    public Long getBookCountByCategory(String category) {
        return bookRepository.countBookByCategoryEquals(category);
    }

    public Long getBookCountByHotList() {
        return bookRepository.countBookByInHotListEquals(1);
    }
    /*Get distinct sub-categories*/

    public List<String> getSubCategory() {
        return bookRepository.findDistinctBySubCategory();
    }

    /*Get hot-list*/
    public List<ExplorePageProjection> getHotList(Integer pageNo, Integer pageSize) {
        Pageable paging = PageRequest.of(pageNo, pageSize);

        Page<ExplorePageProjection> pagedResult = bookRepository.findByInHotListEquals(paging, 1);
        return pagedResult.toList();
    }

    /*get last released books limit 10*/
    public List<ExplorePageProjection> getLastReleased(Integer pageNo, Integer pageSize) {
        Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<ExplorePageProjection> pagedResult = bookRepository.findTop10ByOrderByReleasedTimeDesc(paging);
        return pagedResult.toList();
    }

    /*Get book details by id*/
    public BookDetailsProjection getBookById(Integer ISBN) {
        return bookRepository.findByBookId(ISBN);
    }

    /*problem with paging,page size ı normalden büyük tutmak lazım*/
    public List<BookDetailsProjection> getBookByFilters(Integer pageNo, Integer pageSize, String author, ArrayList<String> category, Integer minPrice, Integer maxPrice) {
        BookSpecification filter_categories = new BookSpecification();
        List<BookDetailsProjection> finalBookList = new ArrayList<>();

        if (!author.equals("undefined")) {
            filter_categories.add(new SearchCriteria("author", author, SearchOperation.MATCH));
        }
        if (!category.isEmpty()) {
            filter_categories.forWords(category);
        }
        List<Book> nopage = bookRepository.findAll(filter_categories.forWords(category).and(filter_categories));
        if (minPrice != -1 && maxPrice != -1) {
            for (Book b : nopage) {
                if (b.getPriceList().get(b.getPriceList().size() - 1).getPrice() >= minPrice &&
                        b.getPriceList().get(b.getPriceList().size() - 1).getPrice() <= maxPrice) {
                    finalBookList.add(ProjectionConverter(b));
                }
            }
        } else if (minPrice != -1) {
            for (Book b : nopage) {
                if (b.getPriceList().get(b.getPriceList().size() - 1).getPrice() >= minPrice) {
                    finalBookList.add(ProjectionConverter(b));
                }
            }
        } else if (maxPrice != -1) {
            for (Book b : nopage) {
                if (b.getPriceList().get(b.getPriceList().size() - 1).getPrice() <= maxPrice) {
                    finalBookList.add(ProjectionConverter(b));
                }
            }
        }
        int finalBookListSize = finalBookList.size();
        int start_index = pageNo * pageSize;
        int end_index = ((pageNo + 1) * pageSize);

        if (finalBookListSize == 0) {
            for (Book b : nopage) {
                finalBookList.add(ProjectionConverter(b));
            }
            finalBookListSize = finalBookList.size();

        }
        if (finalBookListSize >= start_index) {
            if (finalBookListSize >= end_index)
                return finalBookList.subList(start_index, end_index);
            else
                return finalBookList.subList(start_index, finalBookListSize);
        }
        return new ArrayList<>();
    }


    @Transactional //Applied discount to a single item
    public String applyDiscount(Integer book_id, Integer percentage) {
        Optional<Book> optionalBook = bookRepository.findById(book_id);
        Book book = optionalBook.get();
        int last_price = book.getPriceList().size() - 1;
        Float currentPrice = book.getPriceList().get(last_price).getPrice();
        Float newPrice = currentPrice - (currentPrice * percentage) / 100;

        Price discountPrice = new Price();
        discountPrice.setISBN(book.getBookId());
        discountPrice.setPrice(newPrice);
        priceRepository.save(discountPrice);
        book.setInDiscount(1);

        return String.format("Old price = %.2f. New Price is =%.2f ", currentPrice, newPrice);
    }

    public Long getBookCountByFilters(String author, ArrayList<String> category, Integer minPrice, Integer maxPrice) {
        BookSpecification filter_categories = new BookSpecification();
        List<Book> finalBookList = new ArrayList<>();
        if (!author.equals("undefined")) {
            filter_categories.add(new SearchCriteria("author", author, SearchOperation.MATCH));
        }
        if (!category.isEmpty()) {
            filter_categories.forWords(category);
        }
        List<Book> pre_list = bookRepository.findAll(filter_categories.forWords(category).and(filter_categories));
        if (minPrice != -1 && maxPrice != -1) {
            for (Book b : pre_list) {
                if (b.getPriceList().get(b.getPriceList().size() - 1).getPrice() >= minPrice &&
                        b.getPriceList().get(b.getPriceList().size() - 1).getPrice() <= maxPrice) {
                    finalBookList.add(b);
                }
            }
        } else if (minPrice != -1) {
            for (Book b : pre_list) {
                if (b.getPriceList().get(b.getPriceList().size() - 1).getPrice() >= minPrice) {
                    finalBookList.add(b);
                }
            }
        } else if (maxPrice != -1) {
            for (Book b : pre_list) {
                if (b.getPriceList().get(b.getPriceList().size() - 1).getPrice() <= maxPrice) {
                    finalBookList.add(b);
                }
            }
        }
        if (finalBookList.isEmpty())
            return (long) pre_list.size();

        return (long) finalBookList.size();
    }

    public BookDetailsProjection ProjectionConverter(Book book) {
        return new BookDetailsProjection() {
            @Override
            public String getBookName() {
                return book.getBookName();
            }

            @Override
            public String getCategory() {
                return book.getCategory();
            }

            @Override
            public String getSubCategory() {
                return book.getSubCategory();
            }

            @Override
            public String getBookImage() {
                return book.getBookImage();
            }

            @Override
            public String getAuthor() {
                return book.getAuthor();
            }

            @Override
            public Integer getBookId() {
                return book.getBookId();
            }

            @Override
            public Integer getInDiscount() {
                return book.getInDiscount();
            }

            @Override
            public Integer getQuantity() {
                return book.getQuantity();
            }

            @Override
            public Long getRealIsbn() {
                return book.getRealIsbn();
            }

            @Override
            public String getDescription() {
                return book.getDescription();
            }

            @Override
            public List<Price> getPriceList() {
                return book.getPriceList();
            }
        };
    }

}
