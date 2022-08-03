from django.shortcuts import render
from django.http.response import HttpResponse, JsonResponse
from rest_framework.decorators import api_view
from usercomponents.models import PersonSerializer, User
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

    duplicateUsers = dict()

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

    personSerializer = PersonSerializer(savedUser)
    print(personSerializer.data)

    response = {
        "message": "Account Created",
        "result":{
            "userID": personSerializer.data["id"],
            "name": personSerializer.data["name"],
            "email": personSerializer.data["email"]
        },
        "date-time": datetime.datetime.now()
    }

    return JsonResponse(response)

