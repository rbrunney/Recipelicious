import socketio

sio = socketio.Client()

@sio.event
def connect():
    print('connection established')

@sio.event
def disconnect():
    print("disconnected from server")

@sio.on('chat message')
def chatmessage(data):
    print("response from server")
    for item in data:
        print(str(item))
    


sio.connect("http://localhost:8000/", wait_timeout=10)
print(sio.namespaces)
while(True):
    testinput = input("enter input: ")
    sio.emit('chat message', testinput, namespace="/")
