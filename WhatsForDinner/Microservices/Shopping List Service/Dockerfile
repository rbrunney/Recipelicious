FROM tomcat:9.0-jdk11-openjdk

ENV PORT_DB=27017
ENV DB="meals"
ENV HOST_DB="mongodb"
ENV EUREKA_HOST="eureka"

COPY ./ShoppingListService/target/ShoppingListService-1.0.0.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080