package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Comment;
import com.bookland.demobookland.model.Customer;
import com.bookland.demobookland.model.projections.CommentProjection;
import com.bookland.demobookland.repository.CommentRepository;
import com.bookland.demobookland.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CommentServices {
    @Autowired
    CommentRepository commentRepository;

    @Autowired
    CustomerRepository customerRepository;

    public List<CommentProjection> getBookComments(Integer pageNo, Integer pageSize, Integer isbn) {
        Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<Comment> commentsBook = commentRepository.findAllByBookId(paging, isbn);
        List<CommentProjection> commentsProjection = new ArrayList<>();
        for (Comment comment : commentsBook) {
            Integer commenter_id = comment.getCustomerId();
            Customer commenter = customerRepository.findByCustomerId(commenter_id);
            System.out.println(commenter.getFirstName());
            commentsProjection.add(CommentConvert(commenter.getFirstName(), commenter.getSurname(), comment.getCommentText()));
        }
        return commentsProjection;
    }

    public CommentProjection CommentConvert(String name, String surname, String commentText) {
        return new CommentProjection() {
            @Override
            public String getCommenterName() {
                return name;
            }

            @Override
            public String getCommenterSurname() {
                return surname;
            }

            @Override
            public String getCommentText() {
                return commentText;
            }
        };
    }
}
