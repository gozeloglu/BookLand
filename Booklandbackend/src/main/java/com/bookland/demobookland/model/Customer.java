package com.bookland.demobookland.model;

public class Customer {
    private String name;
    private String surname;
    private String doB;
    private String phoneNumber;
    private String email;
    private String password;

    public Customer(String name, String surname, String doB, String phoneNumber, String email, String password) {
        this.name = name;
        this.surname = surname;
        this.doB = doB;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.password = password;
    }

    public Customer() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getDoB() {
        return doB;
    }

    public void setDoB(String doB) {
        doB = doB;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
