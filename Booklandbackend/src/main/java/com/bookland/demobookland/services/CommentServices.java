package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Comment;
import com.bookland.demobookland.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentServices {
    @Autowired
    private CommentRepository commentRepository;

    public Comment comment(Comment comment) {
        return commentRepository.save(comment);
    }
}
