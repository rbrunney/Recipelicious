from django.db import models
from rest_framework import serializers
from djongo import models

# Create your models here.

class Person(models.Model):
    userId = models.BigIntegerField()
    name = models.CharField(max_length=2048)

class Channels(models.Model):
    _id = models.ObjectIdField()
    invitedPeople = models.ArrayField(
        model_container=Person
    )

class ChannelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Channels
        fields = ["_id","invitedPeople"]