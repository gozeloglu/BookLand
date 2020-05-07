package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Search;
import com.bookland.demobookland.model.projections.ExplorePageProjection;
import com.bookland.demobookland.repository.BookRepository;
import com.bookland.demobookland.repository.SearchRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SearchServices {

    @Autowired
    private BookRepository bookRepository;


    @Autowired
    private SearchRepository searchRepository;


    public List<ExplorePageProjection> getBookBySearchCriteria(Integer pageNo, Integer pageSize, Integer customerId, String keyword) {
        try {
            Long isbn = Long.parseLong(keyword);
            Pageable paging = PageRequest.of(pageNo, pageSize);
            Page<ExplorePageProjection> pagedResult = bookRepository.findByRealIsbn(paging, isbn);

            if (!pagedResult.isEmpty()) {
                Search searchedWord = new Search();
                searchedWord.setCustomerId(customerId);
                searchedWord.setSearchedWord(keyword);
                searchRepository.save(searchedWord);
            }

            return pagedResult.toList();
        } catch (Exception e) {
            Pageable paging = PageRequest.of(pageNo, pageSize);
            Page<ExplorePageProjection> pagedResult = bookRepository.findByAuthorContainsOrBookNameContainsOrCategoryContainsOrSubCategoryContains(paging, keyword, keyword, keyword, keyword);

            if (!pagedResult.isEmpty()) {
                Search searchedWord = new Search();
                searchedWord.setCustomerId(customerId);
                searchedWord.setSearchedWord(keyword);
                searchRepository.save(searchedWord);
            }

            return pagedResult.toList();
        }
    }
}
