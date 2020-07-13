package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Campaign;
import com.bookland.demobookland.services.CampaignServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CampaignController {

    @Autowired
    CampaignServices campaignServices;

    @GetMapping(value = "/getCampaigns/{pageNo}/{pageSize}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Campaign> getCampaigns(@PathVariable Integer pageNo, @PathVariable Integer pageSize) {
        return campaignServices.getCampaigns(pageNo - 1, pageSize);
    }

    @GetMapping(value = "/getCampaignCount", produces = MediaType.APPLICATION_JSON_VALUE)
    public Long getCampaignCount() {
        return campaignServices.getCampaignCount();
    }
}
