package com.example.demo.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/demo")
public class TestController {

    @GetMapping("/getMessage")
    public ResponseEntity<String> getTestMessage(){
        return ResponseEntity.ok("Hi, User. getting this message after deploying the project into server.");
    }
}
