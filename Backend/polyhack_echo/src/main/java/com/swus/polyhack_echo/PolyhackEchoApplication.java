package com.swus.polyhack_echo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class PolyhackEchoApplication {
    public static void main(String[] args) {
        SpringApplication.run(PolyhackEchoApplication.class, args);
    }
}
