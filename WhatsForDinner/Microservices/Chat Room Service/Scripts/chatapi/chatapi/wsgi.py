"""
WSGI config for chatapi project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.1/howto/deployment/wsgi/
"""

import os
import socketio
import eventlet
import eventlet.wsgi

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'chatapi.settings')

application = get_wsgi_application()

#so this is all for SocketIO
#Basically this registers as a WSGI app
#Once that's done we pass off the WSGI shenanigans to eventlet
#That handles all the heartbeat requests clients send to the server
sio = socketio.Server(cors_allowed_origins="*")
app = socketio.WSGIApp(sio, application)
@sio.on("chat message")
def handleMessage(sid, data):
    print(data)
    sio.emit('chat message', data)

@sio.event()
def connect(sid, data):
    print("test ,", sid)

@sio.on('chatmessage')
def onMessage(sid, data):
    print(str(data))
    sio.emit('chatmessage', "echoback: " + str(data))





eventlet.wsgi.server(eventlet.listen(('', 8000)), app)


