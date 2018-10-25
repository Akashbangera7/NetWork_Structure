package com.me.web.webapi_assignment3;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.me.web.service", "com.me.web.dao", "com.me.web.webapi_assignment3", "com.me.web.pojo"})
public class WebapiAssignment3Application {

    public static void main(String[] args) {
        SpringApplication.run(WebapiAssignment3Application.class, args);
    }
}
