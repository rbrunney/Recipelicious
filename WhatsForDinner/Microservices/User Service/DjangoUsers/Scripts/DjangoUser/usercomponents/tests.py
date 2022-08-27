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

        userId = response.json()["result"]["userID"]

        getResponse = djangoClient.get(f"/getUser/{userId}")

        print(getResponse.json())

        self.assertNotEqual(response, None)
        self.assertEqual(response.json()["message"],"Account Created")
        self.assertEqual(response.json()["result"]["userID"], 8)
        self.assertEqual(response.json()["result"]["name"], "testymctest")
        self.assertEqual(response.json()["result"]["email"], "testyemail@email.com")
        self.assertNotEqual(response.json()["date-time"], None)

        self.assertEqual(getResponse.json()["name"], "testymctest")
        self.assertEqual(getResponse.json()["username"], "blah0214")
        self.assertEqual(getResponse.json()["email"], "testyemail@email.com")
        self.assertEqual(getResponse.json()["birthday"], "2004-12-03")

    def testCreateAndBlockDuplicateUser(self):
        #man, I hate non sequential testing.
        #checking userIDs is mildly annoying
        userData = {
            "name": "testymctest04",
            "username": "blah02145",
            "password": "defoAPassword",
            "email":"testyemailmk2@email.com",
            "birthday":"2004-12-03"
        }

        djangoClient = Client()
        response = djangoClient.post("/createUser/", userData)

        print(response.json())

        self.assertNotEqual(response, None)
        self.assertEqual(response.json()["message"],"Account Created")
        self.assertEqual(response.json()["result"]["userID"], 6)
        self.assertEqual(response.json()["result"]["name"], "testymctest04")
        self.assertEqual(response.json()["result"]["email"], "testyemailmk2@email.com")
        self.assertNotEqual(response.json()["date-time"], None)

        duplicateResponse = djangoClient.post("/createUser/", userData)

        print(duplicateResponse.json())

        self.assertNotEqual(duplicateResponse, None)
        self.assertEqual(duplicateResponse.json()["message"],"Account already created")
        self.assertEqual(duplicateResponse.json()["result"]["userID"], 6)
        self.assertEqual(duplicateResponse.json()["result"]["name"], "testymctest04")
        self.assertEqual(duplicateResponse.json()["result"]["email"],"testyemailmk2@email.com")

    def testUpdateOnNonexistentUser(self):
        nonexistentUser = "whothef@email.com"

        data = {
            "email": nonexistentUser,
            "updateFields":{
                "name":"dingus",
                "username":"newguy"
            }
        }

        djangoClient = Client()
        response = djangoClient.put("/updateUser/", data, content_type="application/json")

        print(response.json())

        self.assertNotEqual(response, None)
        self.assertEqual(response.json()["message"], "Account not found")
        self.assertNotEqual(response.json()["date-time"], None)

    def testUpdateUser(self):
        userData = {
            "name": "testymctest05",
            "username": "blah02146",
            "password": "defoAPassword",
            "email":"testyemailmk3@email.com",
            "birthday":"2004-12-03"
        }

        djangoClient = Client()
        response = djangoClient.post("/createUser/", userData)

        print(response.json())

        userId = response.json()["result"]["userID"]
        userEmail = response.json()["result"]["email"]

        userEmail = "testyemailmk3@email.com"

        updateData = {
            "email": userEmail,
            "updateFields":{
                "name": "dingus",
                "username": "blandness",
                "email": "testyouremail@email.com"
            }
        }

        updateResponse = djangoClient.put("/updateUser/", updateData, content_type="application/json")

        print(updateResponse.json())

        self.assertEqual(updateResponse.json()["message"], "Account Updated")
        self.assertEqual(updateResponse.json()["result"]["userID"], userId)
        self.assertEqual(updateResponse.json()["result"]["name"], "dingus")
        self.assertEqual(updateResponse.json()["result"]["email"], "testyouremail@email.com")
        self.assertNotEqual(updateResponse.json()["date-time"], None)

        userId = updateResponse.json()["result"]["userID"]

        getResponse = djangoClient.get(f"/getUser/{userId}")

        print(getResponse.json())

        self.assertEqual(getResponse.json()["name"],"dingus")
        self.assertEqual(getResponse.json()["username"],"blandness")
        self.assertEqual(getResponse.json()["email"], "testyouremail@email.com")
        self.assertEqual(getResponse.json()["birthday"], "2004-12-03")

    def testCheckPw(self):
        userData = {
            "":""
        }
