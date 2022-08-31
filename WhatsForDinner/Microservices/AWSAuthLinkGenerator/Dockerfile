FROM tomcat:9.0-jdk11-openjdk

ENV EUREKA_HOST="eureka"
ENV AWS_ACCESS_KEY="AKIA44BUTMDZDTGEYMKS"
ENV AWS_SECRET_KEY="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"

COPY ./target/AWSAuthLinkGenerator-0.0.1-SNAPSHOT.jar /usr/local/tomcat/webapps/ROOT.jar
ENTRYPOINT ["java","-jar","/usr/local/tomcat/webapps/ROOT.jar"]
EXPOSE 8080