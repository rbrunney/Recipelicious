from datetime import datetime, tzinfo
import socketio
import pytz

sio = socketio.Client()


@sio.on("connect")
def connectionMessage():
    print("connected to server")
    response = {
        "groupName":"test",
        "userID":3
    }

    sio.emit("connectToRoom",response)

@sio.on("disconnect")
def disconnectMessage():
    print("disconnected from server")

@sio.on('chatmessage')
def messsageRecieved(data):
    print(data)

sio.connect("http://localhost:8888/", wait_timeout=10)


@sio.on("room-response")
def roomResponseReceived(data):
    print(data)

while(True):
    message = input("Enter a message: ")
    response = {
        "groupName": "test",
        "message":{
            "userID":3,
            "name":"David",
            "content": message,
            "postTime": str(datetime.now(tz=pytz.UTC))
        }
    }
    sio.emit("roommessage", response)
