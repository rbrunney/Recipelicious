package com.whatsfordinner.awsauthlinkgenerator.models;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

public class AWSS3Config {
    static private final String accessKeyId = System.getenv("AWS_ACCESS_KEY");

    static private final String accessSecretKey = System.getenv("AWS_SECRET_KEY");

    static public AmazonS3 getAmazonS3Client() {
        final BasicAWSCredentials basicAWSCredentials = new BasicAWSCredentials(accessKeyId, accessSecretKey);

        return AmazonS3ClientBuilder
                .standard()
                .withCredentials(new AWSStaticCredentialsProvider(basicAWSCredentials))
                .withRegion(Regions.US_WEST_1)
                .build();
    }
}
