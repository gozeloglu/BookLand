package com.bookland.demobookland.model.projections;

import java.util.Date;
import java.util.List;

public interface OrderDetailAdminProjection {
    String getCardNo();

    Integer getOrderId();

    Date getOrderedTime();

    String getFirstName();

    String getSurname();

    String getAddressLine();

    String getCity();

    String getCountry();

    String getStatus();

    String getCompanyName();

    String getCoupon();

    Integer getCustomerId();

    List<OrderDifferentProjection> getDifference();
}
