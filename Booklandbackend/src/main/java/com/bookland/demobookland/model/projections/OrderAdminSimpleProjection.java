package com.bookland.demobookland.model.projections;

import java.util.Date;

public interface OrderAdminSimpleProjection {

    Float getTotalAmount();

    String getCustomerName();

    String getCustomerSurname();

    Date getOrderedDate();
}
