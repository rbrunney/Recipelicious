import mysql.connector
import py_eureka_client.eureka_client as eureka_client
import os

#gotta change to the target mysqlcontainer

connection = mysql.connector.connect(user=os.environ.get("MYSQL_USER"), password=os.environ.get("MYSQL_PASS"), host=os.environ.get("MYSQL_HOST"), port=int(os.environ.get("MYSQL_PORT")))

cursor = connection.cursor()

cursor.execute(
    "CREATE DATABASE IF NOT EXISTS djangousers"
)

#Stopgap measure for create usercomponent's tables
cursor.execute(
    "USE djangousers; CREATE TABLE IF NOT EXISTS usercomponents_user ( id BIGINT NOT NULL AUTO_INCREMENT, name varchar(1024), username varchar(1024), password varchar(5000), email varchar(6000), birthday date, PRIMARY KEY(id))"
)

cursor.close()
connection.close()

#port this server runs on
serverPort = 8000


eurekaString = "http://localhost:5000/" #make sure to set this to an exposed environment variable.

print(os.environ.get("EUREKA_SERVER"))

if os.environ.get("EUREKA_SERVER") != None:
    print("stepped into if statement")
    eurekaString =  os.environ.get("EUREKA_SERVER")

eureka_client.init(eureka_server=eurekaString, app_name="django-users", instance_port=serverPort)
