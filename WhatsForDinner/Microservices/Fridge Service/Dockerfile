FROM tomcat:9.0-jdk11-openjdk

ENV PORT_DB=3306
ENV DB="fridge"
ENV HOST_DB="mongodb"

COPY ./Fridge_Service/target/Fridge_Service-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080