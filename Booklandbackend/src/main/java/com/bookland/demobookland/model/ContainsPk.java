package com.bookland.demobookland.model;

import lombok.Data;

import java.io.Serializable;

@Data
public class ContainsPk implements Serializable {
    private Integer orderId;
    private Integer isbn;
    private Integer trackingNumber;
}
