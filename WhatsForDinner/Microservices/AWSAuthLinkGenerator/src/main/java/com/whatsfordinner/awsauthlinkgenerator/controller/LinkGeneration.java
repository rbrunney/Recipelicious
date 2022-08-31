package com.whatsfordinner.awsauthlinkgenerator.controller;

import com.amazonaws.HttpMethod;
import com.amazonaws.services.s3.model.ResponseHeaderOverrides;
import com.whatsfordinner.awsauthlinkgenerator.models.AWSS3Config;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/generateLink")
public class LinkGeneration {

    @GetMapping("/put/{filePath}")
    public ResponseEntity<Map<String, Object>> generateLink(@PathVariable String filePath) {
        Map<String, Object> response = new HashMap<>();

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.MINUTE, 10); //validity of 10 minutes

        ResponseHeaderOverrides responseHeaders = new ResponseHeaderOverrides();
        responseHeaders.setContentType("image/jpeg");

        response.put("message", "Link Generated");
        response.put("results", AWSS3Config.getAmazonS3Client().generatePresignedUrl("whatsfordinner-pro290", filePath, calendar.getTime(), HttpMethod.PUT).toString());
        response.put("date-time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/get/{filePath}")
    public ResponseEntity<Map<String, Object>> generateGetLink(@PathVariable String filePath) {
        Map<String, Object> response = new HashMap<>();

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.MINUTE, 10); //validity of 10 minutes

        ResponseHeaderOverrides responseHeaders = new ResponseHeaderOverrides();
        responseHeaders.setContentType("image/jpeg");

        response.put("message", "Link Generated");
        response.put("results", AWSS3Config.getAmazonS3Client().generatePresignedUrl("whatsfordinner-pro290", filePath, calendar.getTime(), HttpMethod.GET).toString());
        response.put("date-time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
