package com.bookland.demobookland.model.projections;

import java.util.Date;

public interface OrderAdminSimpleProjection {

    Float getTotalAmount();

    Integer getOrderId();

    String getStatus();

    String getCustomerName();

    String getCustomerSurname();

    Date getOrderedDate();
}
