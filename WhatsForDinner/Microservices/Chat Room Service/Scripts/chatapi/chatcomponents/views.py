from collections import OrderedDict
from datetime import datetime
import json
from django.http.response import HttpResponse, JsonResponse
from django.shortcuts import render
from rest_framework.decorators import api_view
from chatcomponents.models import Person, Channels, ChannelSerializer
import socketio

# Create your views here.

#psuedocode time!
#Users can create a chatroom. To tie a user to a chatroom, use their SQL primary key and store it under a mongodb doc as 
#owning_id or owner_id or some such. We'll tie a bunch of user ids into an array of allowed_users.
#We'll keep track of the rooms via the mongodb objectID. 
#Serve these in the frontend to applicable users. Going to have to set up another mongodb database for this.
#When a user connects to a specific chatroom, pull up the redis logs for that day and meals and broadcast to connected users for that room.
#meals will either be pulled from the user's specific collections or wherever - maybe we have a search bar to pull meals.
#once all users disconnect the chatroom itself will be emptied at the end of the day - maybe a little tough due to TIMEZONES
#gonna be rough, having both redis and mongodb

#UPDATE: Redis can piss off.
#All messages are serialized into mongodb arraylists and we're grabbing user rooms by lists of invited users
#To be honest we'd have a full room deletion system with owning user ids but it's been a bit and really I'm not
#adding more to this until I need to add more.

@api_view(("POST",))
def createRooms(request, *args, **kwargs):
    requestData = request.data

    personList = []

    for person in requestData["invitedPeople"]:
        
        # newPerson = Person(userID=person["userID"], name=person["name"])
        # Apparently you don't serialize person objects into the array field for Channels. 
        # Go figure.
        newPerson = {
            "userID": person["userID"],
            "name": person["name"],
        }

        personList.append(newPerson)


    dataToSave = {
        "groupName": requestData["groupName"],
        "invitedPeople": personList
    }

    print(dataToSave)

    channelToSave = Channels(groupName = requestData["groupName"], invitedPeople = personList, messages = [])

    channelToSave.save()

    response = {
        "message": f'{requestData["groupName"]} has been created',
        "date-time": datetime.now()
    }

    return JsonResponse(response)

@api_view(("GET",))
def getUserRooms(request, *args, **kwargs):
    userID = kwargs["id"]

    serializer = ChannelSerializer(Channels.objects.filter(invitedPeople={"userID":userID})[0:50], many=True)

    # print(serializer.data)


    responseList = []


    for dictionary in serializer.data:
        rawDict = OrderedDict(dictionary)
        response = {
            "_id": rawDict["_id"],
            "groupName": rawDict["groupName"],
            "invitedPeople": json.loads(rawDict["invitedPeople"])
        }
        responseList.append(response)


    return JsonResponse(responseList, safe=False)
