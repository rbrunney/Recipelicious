import py_eureka_client.eureka_client as eureka_client
import os


serverPort = 8000


eurekaString = "http://localhost:5000/" #make sure to set this to an exposed environment variable.

print(os.environ.get("EUREKA_SERVER"))

if os.environ.get("EUREKA_SERVER") != None:
    print("stepped into if statement")
    eurekaString =  os.environ.get("EUREKA_SERVER")

eureka_client.init(eureka_server=eurekaString, app_name="django-chat", instance_port=serverPort)

