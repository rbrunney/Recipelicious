import mysql.connector

#gotta change to the target mysqlcontainer
connection = mysql.connector.connect(user='djangologin', password='abcd@12#F', host="localhost")

cursor = connection.cursor()

cursor.execute(
    "CREATE DATABASE IF NOT EXISTS djangousers"
)

cursor.close()
connection.close()