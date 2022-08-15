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

@api_view(('GET',))
def checkPw(request, *args, **kwargs):
    #Path variables are stored in kwargs
    print(kwargs.values())

    #Gotta do encryption on the password - waiting on flutter frontend for it first
    username = kwargs["username"]
    password = kwargs["password"]

    usertoVerify = User.objects.get(username=username)

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
            JsonResponse(response)
        else:
            response = {
                "message": "Incorrect password given",
                "date-time": datetime.datetime.now()
            }
            JsonResponse(response, status=401)
    except Exception as e:
        print(e.with_traceback.__str__())
        response = {
            "message": "Account not found",
            "date-time": datetime.datetime.now()
        }
        JsonResponse(response, status=404)




