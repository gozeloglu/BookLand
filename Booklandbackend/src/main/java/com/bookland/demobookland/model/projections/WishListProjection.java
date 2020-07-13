package com.bookland.demobookland.model.projections;

import com.bookland.demobookland.model.Price;

import java.util.List;

public interface WishListProjection {
    String getBookName();

    Integer getBookId();

    String getAuthor();

    String getBookImage();

    List<Price> getPriceList();

    Integer getInDiscount();
}
