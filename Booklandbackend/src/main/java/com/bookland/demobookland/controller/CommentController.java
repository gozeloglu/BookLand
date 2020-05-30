package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.projections.CommentProjection;
import com.bookland.demobookland.services.CommentServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CommentController {

    @Autowired
    CommentServices commentServices;

    @GetMapping(value = "/getBookComments/{pageNo}/{pageSize}/{ISBN}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<CommentProjection> getBookComments(@PathVariable Integer pageNo, @PathVariable Integer pageSize, @PathVariable Integer ISBN) {
        return commentServices.getBookComments(pageNo - 1, pageSize, ISBN);
    }

    @GetMapping(value = "/getBookComments/{ISBN}", produces = MediaType.APPLICATION_JSON_VALUE)
    public Long getBookCommentCount(@PathVariable Integer ISBN) {
        return commentServices.getBookCommentCount(ISBN);
    }
}
