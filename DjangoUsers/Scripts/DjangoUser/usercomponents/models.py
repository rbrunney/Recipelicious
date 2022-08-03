from django.db import models
from rest_framework import serializers
# Create your models here.

class User(models.Model):
    name = models.CharField(max_length=1024)
    username = models.CharField(max_length=1024)
    password = models.CharField(max_length=5000)
    email = models.EmailField()
    birthday = models.DateField()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id','name','username','password','email','birthday']