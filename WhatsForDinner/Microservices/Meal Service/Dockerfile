FROM tomcat:9.0-jdk11-openjdk

ENV PORT_DB=27017
ENV DB="MealInfo"
ENV HOST_DB="meal_info_db"
ENV EUREKA_HOST="eureka"

COPY ./MealService/target/MealService-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# ENTRYPOINT ["java","-jar","/usr/local/tomcat/webapps/ROOT.war"] not needed for .war files - tomcat handles all the deployment.
EXPOSE 8080