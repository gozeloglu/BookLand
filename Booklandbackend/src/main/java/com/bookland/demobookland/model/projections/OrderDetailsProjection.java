package com.bookland.demobookland.model.projections;

import java.util.Date;
import java.util.List;

public interface OrderDetailsProjection {
    String getCardNo();

    Date getOrderedTime();

    String getFirstName();

    String getSurname();

    String getAddressLine();

    String getCity();

    String getCountry();

    String getStatus();

    String getCompanyName();

    List<OrderDifferentProjection> getDifference();

}
