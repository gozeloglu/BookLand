package com.bookland.demobookland.model;

import lombok.Data;

import java.io.Serializable;

@Data
public class VotePk implements Serializable {
    private Integer isbn;
    private Integer customerId;
}
