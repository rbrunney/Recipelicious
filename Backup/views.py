from django.shortcuts import render
from rest_framework.decorators import api_view


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

@api_view(("POST",))
def createRooms(request, *args, **kwargs):
    requestData = request.data

    personList = []

    for person in requestData["invitedPeople"]:
        personDetails = {
            "userID": person["userID"],
            "name": person["name"]
        }
        
        personList.append(personDetails)


    dataToSave = {
        "groupName": requestData["groupName"],
        "invitedPeople": personList
    }






