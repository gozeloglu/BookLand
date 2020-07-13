package com.bookland.demobookland.model.projections;

import com.bookland.demobookland.model.Price;

import java.util.List;

public interface BookDetailsProjection {
    String getBookName();

    String getCategory();

    String getSubCategory();

    String getBookImage();

    String getAuthor();

    Integer getBookId();

    Integer getInDiscount();

    Integer getQuantity();

    Long getRealIsbn();

    String getDescription();

    List<Price> getPriceList();
}
