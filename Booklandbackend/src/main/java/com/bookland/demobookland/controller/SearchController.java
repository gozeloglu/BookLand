package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.projections.ExplorePageProjection;
import com.bookland.demobookland.services.SearchServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class SearchController {

    @Autowired
    private SearchServices searchServices;

    @GetMapping(value = "/Search/{pageNo}/{pageSize}/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ExplorePageProjection> getBookBySearchCriteria(@PathVariable Integer pageNo, @PathVariable Integer pageSize, @PathVariable Integer customerId, String keyword) {
        return searchServices.getBookBySearchCriteria(pageNo - 1, pageSize, customerId, keyword);
    }

    @GetMapping(value = "/SearchRecommendation/{customerId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ExplorePageProjection> getBookBySearchHistory(@PathVariable Integer customerId) {
        return searchServices.getBookBySearchHistory(customerId);
    }
}
