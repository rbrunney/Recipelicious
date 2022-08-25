FROM tomcat:8-jdk8-openjdk

ENV EMAIL=noreply.maineventofutah@gmail.com
ENV EMAIL_PASSWORD=vvfjdocyrnmxhthj
ENV RABBITMQ_HOST=rabbitmq
ENV RABBITMQ_PORT=5672
ENV RABBITMQ_USERNAME=guest
ENV RABBITMQ_PASSWORD=guest

COPY ./WFDEmailConsumer/target/WFDEmailConsumer-1.0.jar /usr/local/lib/EmailConsumer.jar

ENTRYPOINT ["java","-jar","/usr/local/lib/EmailConsumer.jar"]

EXPOSE 8080