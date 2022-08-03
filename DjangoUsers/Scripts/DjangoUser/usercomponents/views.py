from django.shortcuts import render
from django.http.response import HttpResponse
from rest_framework.decorators import api_view

# Create your views here.
@api_view(('GET',))
def testView(request, *args, **kwargs):
    return HttpResponse('OK')