package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Search;
import com.bookland.demobookland.model.projections.ExplorePageProjection;
import com.bookland.demobookland.model.projections.KeywordProjection;
import com.bookland.demobookland.repository.BookRepository;
import com.bookland.demobookland.repository.SearchRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

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

    public Long getBookCountBySearchCriteria(String keyword) {
        try {
            Long isbn = Long.parseLong(keyword);
            List<ExplorePageProjection> result = bookRepository.findByRealIsbn(isbn);

            return (long) result.size();
        } catch (Exception e) {
            List<ExplorePageProjection> result = bookRepository.findByAuthorContainsOrBookNameContainsOrCategoryContainsOrSubCategoryContains(keyword, keyword, keyword, keyword);
            return (long) result.size();
        }

    }

    public List<ExplorePageProjection> getBookBySearchHistory(Integer customerId) {
        List<String> words = new ArrayList<>();
        List<Integer> ids = new ArrayList<>();
        List<ExplorePageProjection> recommendationResults = new ArrayList<>();

        if(customerId.equals(-1)){
            return bookRepository.findTop10ByInHotListEquals(1);
        }

        /*top5 yaparsan son 5 aradığı kelimeye göre önerilen kitapları getirir*/
        List<KeywordProjection> lastSearchedWords = searchRepository.findTop10ByCustomerIdOrderByReleasedTimeDesc(customerId);

        /*If there is no search history just recommend the last released books or decide what to show later*/
        if (lastSearchedWords.isEmpty()) {
            List<ExplorePageProjection> lastReleased = bookRepository.findTop10ByOrderByReleasedTimeDesc();
            return lastReleased.stream().limit(10).collect(Collectors.toList());
        }

        for (KeywordProjection keywordProjection : lastSearchedWords) {
            if (!words.contains(keywordProjection.getSearchedWord()))
                words.add(keywordProjection.getSearchedWord());
        }
        for (String word : words) {
            try {
                Long isbn = Long.parseLong(word);
                List<ExplorePageProjection> pagedResultActual = bookRepository.findByRealIsbn(isbn);
                for (ExplorePageProjection exp : pagedResultActual) {
                    if (!ids.contains(exp.getBookId())) {
                        recommendationResults.add(exp);
                        ids.add(exp.getBookId());
                    }
                }
            } catch (Exception e) {
                List<ExplorePageProjection> pagedResultActual = bookRepository.findTop10ByAuthorContainsOrBookNameContainsOrCategoryContainsOrSubCategoryContains(word, word, word, word);
                for (ExplorePageProjection exp : pagedResultActual) {
                    if (!ids.contains(exp.getBookId())) {
                        recommendationResults.add(exp);
                        ids.add(exp.getBookId());
                    }
                }
            }
        }
        Collections.shuffle(recommendationResults);
        return recommendationResults.stream().limit(10).collect(Collectors.toList());
    }
}
