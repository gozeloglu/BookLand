package com.bookland.demobookland.model.projections;

import java.util.Date;
import java.util.List;

public interface OrderDetailsProjection {

    Date getOrderedTime();

    String getAddressLine();

    String getCity();

    String getCountry();

    String getStatus();

    String getCompanyName();

    List<OrderDifferentProjection> getDifference();

    Float getTotalAmount();

    Float getShippingPrice();

}
