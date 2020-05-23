package com.bookland.demobookland.repository;

import com.bookland.demobookland.model.Vote;
import com.bookland.demobookland.model.VotePk;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VoteRepository extends PagingAndSortingRepository<Vote, VotePk> {
}
