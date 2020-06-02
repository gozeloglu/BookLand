package com.bookland.demobookland.model;

import com.bookland.demobookland.model.validationGroups.OrderCreation;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
public class OrderCreateDao {
    @NotBlank(message = "Card Number cannot be empty", groups = OrderCreation.class)
    @Length(min = 16, max = 16, message = "Card Number must be 16 digit number", groups = OrderCreation.class)
    private String cardNo;

    @NotBlank(message = "Card Owner cannot be empty", groups = OrderCreation.class)
    private String cardOwner;

    @NotBlank(message = "Basket cannot be empty", groups = OrderCreation.class)
    private String basketInfo;

    @NotNull(message = "Total Amount must be valid", groups = OrderCreation.class)
    private Float totalAmount;

    private String couponCode;

}
