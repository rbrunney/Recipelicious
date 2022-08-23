from django.shortcuts import render
from django.http.response import HttpResponse, JsonResponse
from rest_framework.decorators import api_view
from usercomponents.models import UserSerializer, User
import bcrypt
import datetime
import pika
import os
import json


rabbitMQHostString = "localhost"

if os.environ.get("RABBITMQ_HOST") != None:
    rabbitMQHostString = os.environ.get("RABBITMQ_HOST")

rabbitMQServerPort = 5672

if os.environ.get("RABBITMQ_PORT") != None:
    rabbitMQServerPort = int(os.environ.get("RABBITMQ_PORT"))

rabbitMQVirtualHost = '/'

if os.environ.get("RABBITMQ_VIRTUAL_HOST") != None:
    rabbitMQVirtualHost = os.environ.get("RABBITMQ_VIRTUAL_HOST")

rabbitUser = "guest"

if os.environ.get("RABBITMQ_USER") != None:
    rabbitUser = os.environ.get("RABBITMQ_USER")

rabbitPass = "guest"

if os.environ.get("RABBITMQ_PASS") != None:
    rabbitPass = os.environ.get("RABBITMQ_PASS")


rabbitMQCredentialParams = pika.PlainCredentials(rabbitUser,rabbitPass)
rabbitMQServerParams = pika.ConnectionParameters(rabbitMQHostString,
                                                rabbitMQServerPort,
                                                rabbitMQVirtualHost,
                                                rabbitMQCredentialParams,
                                                heartbeat=200)

rabbitMQSyncConnection = pika.BlockingConnection(rabbitMQServerParams)

connection_free = True

def blockedConnectionFlag():
    connection_free = False

def unblockedConnectionFlag():
    connection_free = True

rabbitMQSyncConnection.add_on_connection_blocked_callback(blockedConnectionFlag)
rabbitMQSyncConnection.add_on_connection_unblocked_callback(unblockedConnectionFlag)

publishingChannel = rabbitMQSyncConnection.channel()

publishingChannel.exchange_declare("usercreation", durable=True)



# Create your views here.
@api_view(('GET',))
def testView(request, *args, **kwargs):
    return HttpResponse('OK')


@api_view(('POST',))
def createUser(request, *args, **kwargs):
    requestData = request.data

    hashedPass = bcrypt.hashpw(requestData["password"].encode("utf8"), bcrypt.gensalt(10))

    data = User(name = requestData["name"], username = requestData["username"], password = hashedPass.decode("utf8"), email = requestData["email"], birthday = requestData["birthday"])

    duplicateUsers = User()

    try:
        duplicateUsers = User.objects.get(email=data.email)
        print("User already exists, discarding")
    except:
        print("Saving new user")
        data.save()

    if(duplicateUsers != None):
        savedUser = duplicateUsers
    else:
        savedUser = User.objects.get(email=data.email)
        personSerializer = UserSerializer(savedUser)
        response = {
            "message":"Account already created",
            "result":{
                "userID": personSerializer.data["id"],
                "name": personSerializer.data["name"],
                "email": personSerializer.data["email"]
            },
            "date-time": datetime.datetime.now()
        }
        return JsonResponse(response, status=400)

    userSerializer = UserSerializer(savedUser)
    # print(userSerializer.data)



    # if(connection_free):
    #     if(os.path.exists("emailsToSend.json")):
    #         with open('emailsToSend.json','r') as jsonFile:
    #             users = json.load(jsonFile)
    #             for user in users:
    #                 userDetails = {
    #                     "name": user["name"],
    #                     "username": user["username"],
    #                     "email": user["email"],
    #                     "birthday": user["birthday"],
    #                 }
    #                 publishingChannel.basic_publish("usercreation", routing_key="email", body=userDetails)

    #     userDetails ={
    #         "name": userSerializer.data["name"],
    #         "username": userSerializer.data["username"],
    #         "email": userSerializer.data["email"],
    #         "birthday": userSerializer.data["birthday"],
    #     }

    #     publishingChannel.basic_publish("usercreation", routing_key="email", body=json.dumps(userDetails))
    # else:
    #     #store the users that can't be sent off right away and send them off later.
    #     userDetails ={
    #         "name": userSerializer.data["name"],
    #         "username": userSerializer.data["username"],
    #         "email": userSerializer.data["email"],
    #         "birthday": userSerializer.data["birthday"],
    #     }
    #     with open('emailsToSend.json', 'a') as jsonFile:
    #         json.dump(userDetails, jsonFile, indent=4)




    response = {
        "message": "Account Created",
        "result":{
            "userID": userSerializer.data["id"],
            "name": userSerializer.data["name"],
            "email": userSerializer.data["email"]
        },
        "date-time": datetime.datetime.now()
    }

    return JsonResponse(response, status=201)

@api_view(('PUT',))
def updateUser(request, *args, **kwargs):
    requestData = request.data

    hashedPass = bcrypt.hashpw(requestData["password"].encode('utf8'),bcrypt.gensalt(10))

    userToUpdate = User()
    try:
        userToUpdate = User.objects.get(email=requestData["email"])

        setattr(userToUpdate, "name",requestData["name"])
        setattr(userToUpdate, "username",requestData["username"])
        setattr(userToUpdate, "password",hashedPass.decode('utf8'))
        setattr(userToUpdate, "email",requestData["email"])
        setattr(userToUpdate, "birthday",requestData["birthday"])

        userToUpdate.save()
    except:
        response = {
            "message": "Account not found",
            "result": {
                "username": requestData["username"],
                "name": requestData["name"],
                "email": requestData["email"]
            },
            "date-time": datetime.datetime.now()
        }
        return JsonResponse(response, status=400)

    updatedUser = User.objects.get(email=requestData["email"])
    userSerializer = UserSerializer(updatedUser)
    
    print(userSerializer.data)

    response = {
        "message": "Account Updated",
        "result":{
            "userID": userSerializer.data["id"],
            "name": userSerializer.data["name"],
            "email": userSerializer.data["email"]
        },
        "date-time": datetime.datetime.now()
    }

    return JsonResponse(response)

@api_view(('GET',))
def checkPw(request, *args, **kwargs):
    #Path variables are stored in kwargs
    print(kwargs.values())

    #Gotta do encryption on the password - waiting on flutter frontend for it first
    username = kwargs["username"]
    password = kwargs["password"]

    usertoVerify = User()

    try:
        usertoVerify = User.objects.get(username=username)
    except:
        response = {
            "message":"Nonexistent user",
            "date-time": datetime.datetime.now()
        }
        return JsonResponse(response, status=404)

    userSerializer = UserSerializer(usertoVerify)


    if(bcrypt.checkpw(password.encode('utf8'),userSerializer.data["password"].encode('utf8'))):
        print("passwords match!")
    else:
        print("passwords do not match!")        
        response = {
            "message":"Login credentials incorrect",
            "result": bcrypt.checkpw(password.encode('utf8'),userSerializer.data["password"].encode('utf8')),
            "date-time": datetime.datetime.now()
        }
        return JsonResponse(response, status=401)



    response = {
        "message":"Login credentials correct",
        "result": bcrypt.checkpw(password.encode('utf8'),userSerializer.data["password"].encode('utf8')),
        "date-time": datetime.datetime.now()
    }


    return JsonResponse(response)

@api_view(('DELETE',))
def deleteUser(request, *args, **kwargs):
    #need to do token verification so things don't blow up
    #also more decryption for password
    requestData = request.data

    try:
        userToDelete = User.objects.filter(username=requestData["username"])
        userSerializer = UserSerializer(userToDelete)
        if(bcrypt.checkpw(requestData["password"].encode("utf8"),userSerializer.data["password"].encode("utf8"))):
            userToDelete.delete()
            response = {
                "message": "User Account Deleted",
                "date-time": datetime.datetime.now()
            }
            return JsonResponse(response)
        else:
            response = {
                "message": "Incorrect password given",
                "date-time": datetime.datetime.now()
            }
            return JsonResponse(response, status=401)
    except Exception as e:
        print(e.with_traceback.__str__())
        response = {
            "message": "Account not found",
            "date-time": datetime.datetime.now()
        }
        return JsonResponse(response, status=404)


@api_view(("GET",))
def getUser(request, *args, **kwargs):
    userId = kwargs["id"]
    user = User()

    try:
        user = User.objects.get(id=userId)
    except Exception as e:
        print(e.with_traceback.__str__())
        response = {
            "message": "Account not found",
            "date-time": datetime.datetime.now()
        }
        return JsonResponse(response, status=404)
    userSerializer = UserSerializer(user)
    response = {
        'name': userSerializer.data["name"],
        'username': userSerializer.data["username"],
        'email': userSerializer.data["email"],
        'birthday': userSerializer.data["birthday"]
    }
    return JsonResponse(response)