FROM tomcat:9.0-jdk11-openjdk

ENV PORT_DB=27017
ENV DB="MealInfo"
ENV HOST_DB="meal_info_db"
ENV EUREKA_HOST="eureka"

COPY ./Fridge_Service/target/Fridge_Service-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
ENTRYPOINT ["java","-jar","/usr/local/tomcat/webapps/ROOT.war"]
EXPOSE 8080