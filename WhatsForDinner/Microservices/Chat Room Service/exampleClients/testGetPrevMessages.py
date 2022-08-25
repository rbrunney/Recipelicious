from datetime import datetime, tzinfo
import socketio

sio = socketio.Client()

sio.connect("http://localhost:8000")

@sio.on("connect")
def connect():
    print("connected to server")

