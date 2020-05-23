package com.bookland.demobookland.model.projections;

import java.util.Date;

public interface OrderSimpleProjection {

    Date getOrderDate();

    String getStatus();

    Integer getOrderId();

    String getAddressTitle();

    Integer getTotalAmount();
}
