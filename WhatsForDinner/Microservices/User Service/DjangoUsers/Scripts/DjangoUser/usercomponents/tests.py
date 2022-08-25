from django.test import TestCase, Client
from usercomponents.models import User, UserSerializer
import bcrypt
# Create your tests here.

class UserTestCase(TestCase):
    def setUp(self):
        user = User.objects.create(name="test01", username="testUsername", password="blah", email="email@email.com", birthday="2001-02-12")
    
    def testUserDataSerializers(self):
        serializer = UserSerializer(User.objects.get(name="test01"))
        self.assertEqual("test01", serializer.data["name"])
        self.assertEqual("testUsername", serializer.data["username"])
        self.assertEqual("blah", serializer.data["password"])
        self.assertEqual("email@email.com", serializer.data["email"])
        self.assertEqual("2001-02-12", serializer.data["birthday"])

    def testUserSerialization(self):
        user = User.objects.create(name="test01", username="testUsername", password="blah", email="email@dude.com", birthday="2001-02-12")
        user.save()

        returnedUser = User.objects.get(email="email@dude.com")
        serializer = UserSerializer(returnedUser)
        self.assertEqual("test01", serializer.data["name"])
        self.assertEqual("testUsername", serializer.data["username"])
        self.assertEqual("blah", serializer.data["password"])
        self.assertEqual("email@dude.com", serializer.data["email"])
        self.assertEqual("2001-02-12", serializer.data["birthday"])

class testAPIcalls(TestCase):
    def setUp(self):
        salt = bcrypt.gensalt(10)

        password = "dudebropassword"

        hashedPW = bcrypt.hashpw(password.encode("utf8"), salt)

        userToSave = User(name="dude", username="blergh0121", password=hashedPW.decode("utf8"), email="dudeemail@email.com", birthday="2003-04-12")

        userToSave.save()

    def testAPIGetUser(self):
        djangoClient = Client()
        response = djangoClient.get("/getUser/blergh0121")

        print(response)
        print(response.json())
        print(response.json()["result"])
        print(response.json()["userID"])
        print(response.json()["name"])

        self.assertNotEqual(response, None)
        self.assertEqual(response.json()["result"], True)
        self.assertEqual(response.json()["userID"], 4)
        self.assertEqual(response.json()["name"],"dude")

        response = djangoClient.get("/getUser/4")

        print(response)
        print(response.json())
        print(response.json()["name"])
        print(response.json()["username"])
        print(response.json()["email"])
        print(response.json()["birthday"])

        self.assertNotEqual(response, None)
        self.assertEqual(response.json()["name"], "dude")
        self.assertEqual(response.json()["username"], "blergh0121")
        self.assertEqual(response.json()["email"], "dudeemail@email.com")
        self.assertEqual(response.json()["birthday"], "2003-04-12")

    def testCreateAndGetUser(self):

        userData = {
            "name": "testymctest",
            "username": "blah0214",
            "password": "defoAPassword",
            "email":"testyemail@email.com",
            "birthday":"2004-12-03"
        }

        djangoClient = Client()
        response = djangoClient.post("/createUser/", userData)

        print(response.json())
        self.assertNotEqual(response, None)

