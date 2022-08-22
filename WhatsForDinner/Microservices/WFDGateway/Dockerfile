FROM openjdk:latest

ENV EUREKA_HOST 'eureka'
ENV EUREKA_PORT 8761

ARG JAR_FILE=./target/WFDGateway-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} WFDGateway.jar
ENTRYPOINT ["java", "-jar", "./WFDGateway.jar"]