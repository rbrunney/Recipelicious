"""
WSGI config for chatapi project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.1/howto/deployment/wsgi/
"""

import datetime
import json
import os
import socketio
import eventlet
import eventlet.wsgi
import pytz
# import redis
from chatcomponents.models import Person, Channels, ChannelSerializer, ChatMessages
import djongo.database
from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'chatapi.settings')

application = get_wsgi_application()

#so this is all for SocketIO
#Basically this registers as a WSGI app
#Once that's done we pass off the WSGI shenanigans to eventlet
#That handles all the heartbeat requests clients send to the socketio server
# redisServerString = "redis://localhost:6379"

# redisServer = redis.from_url(redisServerString, db=0)

# mgr = socketio.RedisManager(url=redisServerString, channel="channels")
# mgr.pubsub = redisServer.pubsub()
# mgr.pubsub.subscribe("channels")
sio = socketio.Server(cors_allowed_origins="*")#, client_manager=mgr)
app = socketio.WSGIApp(sio, application)
#NOTE
#If you want to add a new @event decorator, be sure to do it before you actually run the socketIO server
#other wise you'll have none of them loaded in the actual server object.

roomListWithUsers = []

@sio.on("chat message")
def handleMessage(sid, data):
    print(data)
    sio.emit('chat message', data)
    # redisServer.rpush("chatTest",str(data))

@sio.event()
def connect(sid, data):
    print("test ,", sid)
    # print(redisServer.lrange("chatTest",0,3000))
    # sio.emit("chatmessage", redisServer.lrange("chatTest", 0, 3000))
    # sio.emit("chatmessage", data)

@sio.on('chatmessage')
def onMessage(sid, data):
    print(str(data))
    sio.emit('chatmessage', "echoback: " + str(data))
    # redisServer.rpush("chatTest",str(data))

@sio.on("testmessages")
def testChannels(sid, data):
    sio.emit("chatmessage", data)
    channelName = data["groupName"]
    channel = Channels.objects.get(groupName = channelName)
    channelSerializer = ChannelSerializer(channel)

    # message = json.loads(data["message"])
    message = data["message"]

    messageList = json.loads(channelSerializer["messages"].value)

    print(message)
    print(messageList)

    messageList.append(message)

    setattr(channel, "messages", messageList)

    channel.save()

@sio.on("connectToRoom")
def checkRoom(sid, data):
    chatroom = data["groupName"]
    # Do objectIds here. This is for testing purposes and in case someone adds a group that's named the same as someone else's.
    channel = Channels.objects.get(groupName = chatroom)
    channelSerializer = ChannelSerializer(channel)
    requestingUser = data["userID"]
    data = channelSerializer.data
    userList = json.loads(data["invitedPeople"])
    # print(type(userList))
    # print(userList)

    #Not a great way to check if the user's a part of a room or not, but since the JSON is so unwieldy it'll have to do.
    for user in userList:
        # print(user)
        #The int conversion is because apparently json doesn't read back numbers as raw numbers. THANKS, JSON.
        if(requestingUser == int(user["userID"])):

            existingChatroom = None

            for room in roomListWithUsers:
                if(room["groupName"] == chatroom):
                    existingChatroom = room
                    roomListWithUsers.remove(room)
                    break

            if(existingChatroom != None):
                userList = list(existingChatroom["userList"])
                userList.append(sid)
                existingChatroom["userList"] = userList
                roomListWithUsers.append(existingChatroom)

            sio.enter_room(sid, chatroom)
            print("room entered")
            sio.emit("chatmessage",f"connected to chatroom {chatroom}")
            break

@sio.on("disconnectFromRoom")
def leaveRoom(sid, data):
    chatroom = data["groupName"]

    existingChatroom = None

    for room in roomListWithUsers:
        if(room["groupName"] == chatroom):
            existingChatroom = room
            roomListWithUsers.remove(room)
            break

    if(existingChatroom != None):
        userList = list(existingChatroom["userList"])
        userList.remove(sid)
        existingChatroom["userList"] = userList
        roomListWithUsers.append(existingChatroom)

    #Again, to be replaced by objectIDs
    sio.leave_room(sid, chatroom)

#do need to secure this a bit, as someone could just slam messages into "roommessage" event and just spam a channel
#so maybe we do a check against the user's id or something
@sio.on("roommessage")
def messageRoom(sid, data):
    #take care to remove a user from a room. They should never have more than one connected room.
    # print(data)
    #Get channel name from incoming data
    channelName = data["groupName"]
    channel = Channels.objects.get(groupName = channelName)

    channelSerializer = ChannelSerializer(channel)
    sendingUser = ""
    #Message isn't just a simple text string but a dictionary.
    message = data["message"]
    isValidUser = False

    #gets the username from the database. Can be replaced by just sending the username over with the message.
    userList = json.loads(channelSerializer.data["invitedPeople"])
    for user in userList:
        if(message["userID"] == int(user["userID"])):
            isValidUser = True
            break
    # Just better to pull the channel from the message itself. Working through roomlist is a pain in the ass.
    # message = json.loads(data["message"])
    # print(sio.rooms(sid))
    # roomlist = sio.rooms(sid=sid)
    # print("roomlist")
    # print(roomlist)
    #grab the message list and append the new message, then save it back to the database.
    if(isValidUser):
        messageList = json.loads(channelSerializer["messages"].value)

        # print(message)
        # print(messageList)

        unlocalDatetime = datetime.datetime.strptime(message["postTime"], "%a %b %d %H %M %S %Y %Z")

        unlocalDatetime = datetime.datetime(unlocalDatetime)

        localDatetime = pytz.utc.localize(unlocalDatetime)

        message["postTime"] = localDatetime

        messageList.append(message)

        setattr(channel, "messages", messageList)

        channel.save()
        #finally make the response and send it off. 
        #change this up to send back the raw json for use
        # roomResponse = f"{sendingUser}: {message['content']}"

        sio.emit("room-response", message, room=channelName, skip_sid=sid)
    else:
        sio.emit("unauthorized", "You are not allowed to access this room", room=sid)

@sio.on("getPrevMessages")
def sendLoadedMessage(sid, data):
    groupName = data["groupName"]
    requestingUser = data["userID"]
    channel = Channels.objects.get(groupName = groupName)
    channelSerializer = ChannelSerializer(channel)
    messages = json.loads(channelSerializer.data["messages"])
    users = json.loads(channelSerializer.data["invitedPeople"])
    validUser = False
    # print(channelSerializer.data)



    for user in users:
        if(requestingUser == int(user["userID"])):
            validUser = True
            break
    if(validUser):
        
        userList = []

        for room in roomListWithUsers:
            if(room["groupName"]==groupName):
                userList = room["userList"]
                break
        
        for user in userList:
            if(sid == user):
                userList.remove(sid)

        sio.emit('room-response', messages, room=groupName, skip_sid=userList)
    else:
        sio.emit('unauthorized',"You are not allowed to access this room", room = sid)
        #grab users
        #get user name by their user ID
        #append to response


        # print(userName)

socketIOPort = 8000

# if os.environ.get("SOCKET_IO_PORT") != None:
#     socketIOPort = int(os.environ.get("SOCKET_IO_PORT"))


#This just lets us run this in parallel with django on the same port.
# eventlet.monkey_patch(socket=True)
eventlet.wsgi.server(eventlet.listen(('', socketIOPort)), app)
