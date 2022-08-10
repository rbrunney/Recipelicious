from django.db import models
from rest_framework import serializers
from djongo import models

# Create your models here.

class Person(models.Model):
    userID = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=2048)

class ChatMessages(models.Model):
    userID = models.IntegerField(primary_key=True)
    content = models.CharField(max_length=6000)
    postTime = models.DateTimeField()

class Channels(models.Model):
    _id = models.ObjectIdField()
    groupName = models.CharField(max_length=2048)
    invitedPeople = models.ArrayField(
        model_container=Person
    )
    messages = models.ArrayField(
        model_container=ChatMessages
    )

class ChannelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Channels
        fields = ["_id","groupName","invitedPeople","messages"]

class PersonSerializer(serializers.ModelSerializer):
    class Meta:
        model = Person
        fields = ["userID","name"]

class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChatMessages
        fields = ["userID", "content", "postTime"]