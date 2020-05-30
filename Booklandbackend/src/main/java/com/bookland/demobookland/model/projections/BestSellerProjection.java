package com.bookland.demobookland.model.projections;

import com.bookland.demobookland.model.Price;

import java.util.List;

public interface BestSellerProjection {

    String getBookName();

    String getAuthor();

    String getBookImage();

    Integer getOrderCount();

    List<Price> getPriceList();

    Integer getInDiscount();
}
