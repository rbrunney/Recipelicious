FROM python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV EUREKA_SERVER="http://eureka:8761/"
ENV MONGO_HOST="mongodb"
ENV MONGO_PORT=27017
ENV MONGO_USER=""
ENV MONGO_PASS=""
ENV MONGO_DB_NAME="db"
# ENV SOCKET_IO_PORT=5001
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt 
COPY . /code/

RUN ls .

CMD python Scripts/chatapi/manage.py runserver