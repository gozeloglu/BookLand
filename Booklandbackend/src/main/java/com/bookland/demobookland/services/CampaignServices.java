package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Campaign;
import com.bookland.demobookland.repository.CampaignRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CampaignServices {

    @Autowired
    CampaignRepository campaignRepository;

    public List<Campaign> getCampaigns(Integer pageNo, Integer pageSize) {
        Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<Campaign> pagedResult = campaignRepository.findAll(paging);
        return pagedResult.toList();
    }

    public Long getCampaignCount() {
        return campaignRepository.count();
    }
}
