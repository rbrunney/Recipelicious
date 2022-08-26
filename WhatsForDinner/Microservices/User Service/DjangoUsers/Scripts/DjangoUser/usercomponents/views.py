import traceback
from django.shortcuts import render
from django.core.exceptions import ObjectDoesNotExist
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





# def blockedConnectionFlag():
#     connection_free = False

# def unblockedConnectionFlag():
    global connection_free
    connection_free = True

# connection_free = True

# rabbitMQSyncConnection.add_on_connection_blocked_callback(blockedConnectionFlag)
# rabbitMQSyncConnection.add_on_connection_unblocked_callback(unblockedConnectionFlag)

# Create your views here.
@api_view(('GET',))
def testView(request, *args, **kwargs):
    return HttpResponse('OK')


@api_view(('POST',))
def createUser(request, *args, **kwargs):
    requestData = request.data

    hashedPass = bcrypt.hashpw(requestData["password"].encode("utf8"), bcrypt.gensalt(10))

    data = User(name = requestData["name"], username = requestData["username"], password = hashedPass.decode("utf8"), email = requestData["email"], birthday = requestData["birthday"])


    duplicateUsers = None

    try:
        duplicateUsers = User.objects.get(email=data.email)
        print("User already exists, discarding")
    except Exception as e:
        # traceback.print_exception(e)
        print("Saving new user")
        data.save()

    if(duplicateUsers != None):
        personSerializer = UserSerializer(duplicateUsers)
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

    userSerializer = UserSerializer(data)
    # print(userSerializer.data)
    userDetails ={
        "name": userSerializer.data["name"],
        "username": userSerializer.data["username"],
        "email": userSerializer.data["email"],
        "birthday": userSerializer.data["birthday"],
    }

    
    rabbitMQCredentialParams = pika.PlainCredentials(rabbitUser,rabbitPass)
    rabbitMQServerParams = pika.ConnectionParameters(rabbitMQHostString,
                                                    rabbitMQServerPort,
                                                    rabbitMQVirtualHost,
                                                    rabbitMQCredentialParams,
                                                    heartbeat=200)

    rabbitMQSyncConnection = pika.BlockingConnection(rabbitMQServerParams)

    publishingChannel = rabbitMQSyncConnection.channel()

    publishingChannel.queue_declare("usercreation", durable=True)


    publishingChannel.basic_publish(exchange='', routing_key="usercreation", body=json.dumps(userDetails))

    publishingChannel.close()

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

    userToUpdate = User()

    salt = bcrypt.gensalt(10)

    email = requestData["email"]

    print(email)

    try:
        userToUpdate = User.objects.get(email=email)
        
        updateDict = dict(requestData["updateFields"])

        keyList = list(updateDict.keys())

        for key in keyList:
            if(key == "password"):
                hashedPassword = bcrypt.hashpw(updateDict["password"].encode("utf8"), salt)
                setattr(userToUpdate, "password", hashedPassword.decode("utf8"))
            elif(key == "name"):
                setattr(userToUpdate, "name", updateDict["name"])
            elif(key == "username"):
                setattr(userToUpdate, "username", updateDict["username"])
            elif(key == "email"):
                setattr(userToUpdate, "email", updateDict["email"])
            elif(key == "birthday"):
                setattr(userToUpdate, "birthday", updateDict["birthday"])

        # hashedPass = bcrypt.hashpw(requestData["password"].encode('utf8'),bcrypt.gensalt(10))

        # setattr(userToUpdate, "name",requestData["name"])
        # setattr(userToUpdate, "username",requestData["username"])
        # setattr(userToUpdate, "password",hashedPass.decode('utf8'))
        # setattr(userToUpdate, "email",requestData["newEmail"])
        # setattr(userToUpdate, "birthday",requestData["birthday"])

        userToUpdate.save()
    except ObjectDoesNotExist as objNotExist:
        traceback.print_exception(etype=ObjectDoesNotExist, value=objNotExist, tb=objNotExist.__traceback__)
        response = {
            "message": "Account not found",
            "date-time": datetime.datetime.now()
        }
        return JsonResponse(response, status=400)
    except KeyError as e:
        traceback.print_exception(etype=KeyError, value=e, tb=e.__traceback__)
        response ={
            "message": "Missing update fields",
            "result": json.dumps(request.data),
            "date-time": datetime.datetime.now()
        }
        return JsonResponse(response, status=400)

    userSerializer = UserSerializer(userToUpdate)
    
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
            "userID": userSerializer.data["id"],
            "result": bcrypt.checkpw(password.encode('utf8'),userSerializer.data["password"].encode('utf8')),
            "date-time": datetime.datetime.now()
        }
        return JsonResponse(response, status=401)



    response = {
        "message":"Login credentials correct",
        "userID": userSerializer.data["id"],
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
    userID = kwargs["id"]
    user = User()

    try:
        user = User.objects.get(id=userID)
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

@api_view(("GET",))
def getUserByUsername(request, *args, **kwargs):
    userUsername = kwargs["username"]
    user = User()

    try:
        user = User.objects.get(username=userUsername)
    except Exception as e:
        print(e.with_traceback.__str__())
        response = {
            'result': False,
        }
        return JsonResponse(response, status=404)
    userSerializer = UserSerializer(user)
    response = {
        'result': True,
        'userID': userSerializer.data["id"],
        'name': userSerializer.data["name"],
    }
    return JsonResponse(response)