package com.bookland.demobookland;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


/*@Configuration
@ComponentScan(basePackages = {"com.bookland.demobookland.controller",
        "com.bookland.demobookland.repository","com.bookland.demobookland.services","com.bookland.demobookland.model"})
@EnableJpaRepositories(basePackages = {"com.bookland.demobookland.repository"})*/
@SpringBootApplication
public class BooklandApplication {
    public static void main(String[] args) {
        SpringApplication.run(BooklandApplication.class, args);
    }

}
