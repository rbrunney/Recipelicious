import email
from django.shortcuts import render
from django.http.response import HttpResponse, JsonResponse
from rest_framework.decorators import api_view
from usercomponents.models import UserSerializer, User
import bcrypt
import datetime

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
    print(personSerializer.data)

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




