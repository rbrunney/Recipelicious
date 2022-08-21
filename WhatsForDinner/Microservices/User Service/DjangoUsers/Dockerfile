FROM python
ENV MYSQL_DBNAME 'djangousers'
ENV MYSQL_USER 'djangologin'
ENV MYSQL_PASS 'abcd12@!F'
ENV MYSQL_HOST 'user_sql_db'
ENV MYSQL_PORT 3306
ENV EUREKA_SERVER 'http://eureka:8761/'
ENV RABBITMQ_HOST 'rabbitmq'
ENV RABBITMQ_PORT 5672

WORKDIR /code
COPY REQUIREMENTS.txt /code/
RUN pip install -r REQUIREMENTS.txt
COPY . /code/
# RUN python Scripts/DjangoUser/manage.py usercomponents makemigrations
# RUN python Scripts/DjangoUser/manage.py makemigrations
# RUN python Scripts/DjangoUser/manage.py migrate
CMD python Scripts/DjangoUser/manage.py runserver 0.0.0.0:8000
