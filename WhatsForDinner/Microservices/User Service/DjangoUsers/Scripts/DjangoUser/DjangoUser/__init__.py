import mysql.connector
import py_eureka_client.eureka_client as eureka_client
import os

#gotta change to the target mysqlcontainer
connection = mysql.connector.connect(user='djangologin', password='abcd@12#F', host="localhost")

cursor = connection.cursor()

cursor.execute(
    "CREATE DATABASE IF NOT EXISTS djangousers"
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
