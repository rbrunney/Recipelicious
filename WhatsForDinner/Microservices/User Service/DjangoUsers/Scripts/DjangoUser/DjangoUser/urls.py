"""DjangoUser URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from usercomponents.views import testView, createUser, updateUser, checkPw, deleteUser, getUser, getUserByUsername, forgotPassword

urlpatterns = [
    #path('admin/', admin.site.urls),
    path('testView/', testView),
    path('createUser/', createUser),
    path('updateUser/', updateUser),
    path('passwordCheck/<str:username>/<str:password>', checkPw),
    path('deleteUser/', deleteUser),
    path('getUser/<int:id>', getUser),
    path('getUser/<str:username>', getUserByUsername),
    path('forgotPassword/', forgotPassword)
]
