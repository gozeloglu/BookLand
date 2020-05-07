package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Comment;
import com.bookland.demobookland.services.CommentServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CommentController {

    @Autowired
    private CommentServices commentServices;

    @PostMapping(value = "/comment")
    public Comment comment(@RequestBody Comment comment) {
        return commentServices.comment(comment);
    }
}
