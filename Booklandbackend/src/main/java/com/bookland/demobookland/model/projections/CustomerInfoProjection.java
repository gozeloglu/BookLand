package com.bookland.demobookland.model.projections;

import java.util.Date;

public interface CustomerInfoProjection {
    String getFirstName();

    String getSurname();

    String getPhoneNumber();

    Date getDateOfBirth();

    String getCustomerId();

    String getEmail();

}
