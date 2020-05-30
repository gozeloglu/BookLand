package com.bookland.demobookland.services;

import com.bookland.demobookland.model.*;
import com.bookland.demobookland.model.SearchCriteria.BookSpecification;
import com.bookland.demobookland.model.SearchCriteria.SearchCriteria;
import com.bookland.demobookland.model.SearchCriteria.SearchOperation;
import com.bookland.demobookland.model.projections.*;
import com.bookland.demobookland.repository.BookRepository;
import com.bookland.demobookland.repository.PriceRepository;
import com.bookland.demobookland.repository.VoteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class BookServices {

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private WishListService wishListService;

    @Autowired
    private VoteRepository voteRepository;

    @Autowired
    private PriceRepository priceRepository;

    public List<ExplorePageProjection> getAllBooks(Integer pageNo, Integer pageSize) {
        Pageable paging = PageRequest.of(pageNo, pageSize);

        Page<ExplorePageProjection> pagedResult = bookRepository.findAllProjectedBy(paging);
        return pagedResult.toList();
    }

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
    public BookDetailsAll getBookById(Integer ISBN) {

        Optional<Book> book = bookRepository.findById(ISBN);
        BookDetailsProjection bp = bookRepository.findByBookId(ISBN);
        Book currentBook = book.get();
        Float vote = getVoteRatio(currentBook);
        Integer inWishList = wishListService.inWishList(2,ISBN);

        return bookDetailsAll(bp, vote, inWishList);
    }


    public BookDetailsAll bookDetailsAll(BookDetailsProjection bp, Float voteRatio, Integer inWishList) {
        return new BookDetailsAll() {
            @Override
            public BookDetailsProjection getDetails() {
                return bp;
            }

            @Override
            public Float getVoteRatio() {
                System.out.println(voteRatio);
                return voteRatio;
            }

            @Override
            public Integer getInWishlist() {
                return inWishList;
            }
        };
    }

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

    public List<CartDetailProjection> cartDetails(Map<String, List<String>> bookIds) {
        List<CartDetailProjection> booksInCart = new ArrayList<>();
        List<String> values = bookIds.get("BookIds");
        for (String s : values) {
            Book b;
            Optional<Book> book = bookRepository.findById(Integer.valueOf(s));
            if (book.isPresent()) {
                b = book.get();
                booksInCart.add(CartConverter(b));
            }
        }
        return booksInCart;
    }

    public CartDetailProjection CartConverter(Book book) {
        return new CartDetailProjection() {
            @Override
            public String getBookName() {
                return book.getBookName();
            }

            @Override
            public Float getPrice() {
                return book.getPriceList().get(book.getPriceList().size() - 1).getPrice();
            }

            @Override
            public String getBookImage() {
                return book.getBookImage();
            }
        };
    }

    public List<BestSellerProjection> getBestSellers() {
        BookSpecification filter_categories = new BookSpecification();
        List<Book> allBooks = bookRepository.findAll(filter_categories);
        Map<Integer, Integer> bookOrders = new HashMap<>();
        List<BestSellerProjection> result = new ArrayList<>();


        for (Book b : allBooks) {
            Integer orderCount = 0;
            for (Contains c : b.getContainsList()) {
                orderCount += c.getQuantity();
            }
            bookOrders.put(b.getBookId(), orderCount);
        }

        Map<Integer, Integer> topTen =
                bookOrders.entrySet().stream()
                        .sorted(Map.Entry.comparingByValue(Comparator.reverseOrder()))
                        .limit(10)
                        .collect(Collectors.toMap(
                                Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));
        allBooks.clear();

        for (Integer i : topTen.keySet()) {
            filter_categories.add(new SearchCriteria("bookId", i, SearchOperation.EQUAL));
            Optional<Book> bestSellerBook = bookRepository.findOne(filter_categories);
            bestSellerBook.ifPresent(book -> result.add(bestSellerConverter(book, topTen.get(i))));
            filter_categories.getList().clear();
        }

        return result;
    }

    public BestSellerProjection bestSellerConverter(Book book, Integer quantity) {
        return new BestSellerProjection() {
            @Override
            public String getBookName() {
                return book.getBookName();
            }

            @Override
            public String getAuthor() {
                return book.getAuthor();
            }

            @Override
            public String getBookImage() {
                return book.getBookImage();
            }

            @Override
            public Integer getOrderCount() {
                return quantity;
            }

            @Override
            public List<Price> getPriceList() {
                return book.getPriceList();
            }

            @Override
            public Integer getInDiscount() {
                return book.getInDiscount();
            }

        };
    }

    public Float voteBook(Vote vote) {
        VotePk votePk = new VotePk();
        votePk.setCustomerId(vote.getCustomerId());
        votePk.setIsbn(vote.getIsbn());
        Optional<Vote> isVote = voteRepository.findById(votePk);

        if (isVote.isPresent())
            return (float) 0;
        else
            voteRepository.save(vote);

        Float f = (float) 0;
        Optional<Book> book = bookRepository.findById(vote.getIsbn());
        Book currentBook = book.get();
        for (Vote v : currentBook.getVoteList()) {
            f += v.getVoteNumber();
        }
        return f / currentBook.getVoteList().size();
    }

    public Float getVoteRatio(Book book) {
        Float ratio = (float) 0;
        System.out.println(book.getVoteList());
        if(book.getVoteList().isEmpty())
            return (float) 0;
        for (Vote vote : book.getVoteList()) {
            ratio += vote.getVoteNumber();
        }
        return ratio / book.getVoteList().size();
    }
}
