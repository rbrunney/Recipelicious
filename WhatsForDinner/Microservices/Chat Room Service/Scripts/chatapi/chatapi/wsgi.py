"""
WSGI config for chatapi project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.1/howto/deployment/wsgi/
"""

import json
import os
import socketio
import eventlet
import eventlet.wsgi
import redis
from chatcomponents.models import Person, Channels, ChannelSerializer, ChatMessages
import djongo.database
from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'chatapi.settings')

application = get_wsgi_application()

#so this is all for SocketIO
#Basically this registers as a WSGI app
#Once that's done we pass off the WSGI shenanigans to eventlet
#That handles all the heartbeat requests clients send to the 
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






#This just lets us run this in parallel with django on the same port.
eventlet.monkey_patch(socket=True)
eventlet.wsgi.server(eventlet.listen(('', 8000)), app)


