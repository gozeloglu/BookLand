package com.bookland.demobookland.model;

import java.util.List;

public interface ExplorePageProjection {
    String getBookName();
    String getBookImage();
    String getAuthor();
    Integer getBookId();
    List<Price> getPriceList();
}
