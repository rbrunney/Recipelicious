from django.db import models
from rest_framework import serializers
from djongo import models

# Create your models here.

class Person(models.Model):
    userID = models.IntegerField(primary_key=True   )
    name = models.CharField(max_length=2048)

class Channels(models.Model):
    _id = models.ObjectIdField()
    groupName = models.CharField(max_length=2048)
    invitedPeople = models.ArrayField(
        model_container=Person
    )

class ChannelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Channels
        fields = ["_id","groupName","invitedPeople"]

class PersonSerializer(serializers.ModelSerializer):
    class Meta:
        model = Person
        fields = ["userID","name"]