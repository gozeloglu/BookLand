package com.bookland.demobookland.model.projections;

import com.bookland.demobookland.model.Price;

import java.util.List;

public interface ExplorePageProjection {
    String getBookName();

    String getBookImage();

    String getAuthor();

    Integer getBookId();

    Integer getInDiscount();

    List<Price> getPriceList();
    //List<Contains> getContainsList();
}
