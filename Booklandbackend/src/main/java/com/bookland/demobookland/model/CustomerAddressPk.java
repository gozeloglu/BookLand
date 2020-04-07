package com.bookland.demobookland.model;

import lombok.Data;

import javax.persistence.Column;
import java.io.Serializable;
@Data

public class CustomerAddressPk implements Serializable {

    private int customerId;
    private int addressId;

}
