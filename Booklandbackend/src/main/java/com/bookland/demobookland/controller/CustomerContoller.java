package com.bookland.demobookland.controller;

import com.bookland.demobookland.model.Customer;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.*;

@RestController
public class CustomerContoller {

    /*localhost:8080 asıl kısım */
    /*value = "/userDetails" http://localhost:8080/userDetails?id=1*/
    /*Get mapping de body yok request param var*/
    /*Post yaparken request mapping yapıp request body yazman lazım */
    /*Produces kısmını json dönmesi için her zaman yaz*/

    @GetMapping(value = "/userDetails", produces = MediaType.APPLICATION_JSON_VALUE)
    public Customer getUserDetails(@RequestParam String id) {

        Customer customer1 = new Customer();

        Connection con = null;

        /*Procedure çağırmaya bak normal sql kodu yerine*/
        /*Eğer birden çok customer özelliği dönceksen arraylist map gibi bişey açıp while da dönmen lazım*/
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                    "jdbc:mysql://mybookstores.mysql.database.azure.com/bookland", "burak@mybookstores", "bookland1!");
            String sql = "Select * from customer where CustomerId=" + id;
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                customer1.setName(rs.getString("Name"));
                /*Ekranda görmek için*/
                System.out.println("ID:" + rs.getString("CustomerId") + "ADI:" + rs.getString("Name"));
            }


        } catch (ClassNotFoundException | SQLException exception) {
            exception.printStackTrace();
        }
        return customer1;
    }

    @GetMapping("/")
    public String getProductss() {
        return "Hello world";
    }


}
