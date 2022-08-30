from itertools import groupby
from django.test import TestCase, Client

# Create your tests here.
class ChatTestCases(TestCase):
    def setUp(self):
        print("init tests")

    def testCreateGroup(self):

        groupData = {
            "groupName": "ohgod",
            "invitedPeople" : [
                {
                    "userID": 2,
                    "name": "Alex"
                },
                {
                    "userID": 3,
                    "name": "David"
                },
                {
                    "userID": 4,
                    "name": "David"
                }
            ]
        }

        print(groupData)
        print(groupData["invitedPeople"][0]["userID"])

        djangoClient = Client()

        response = djangoClient.post("/createRoom/", groupData, "application/json")

        print(response.json())

        self.assertEqual(response.json()["message"], "ohgod has been created")
        self.assertNotEqual(response.json()["date-time"], None)

    def testGetGroup(self):
        groupData = {
            "groupName": "ohgod",
            "invitedPeople" : [
                {
                    "userID": 2,
                    "name": "Alex"
                },
                {
                    "userID": 3,
                    "name": "David"
                },
                {
                    "userID": 4,
                    "name": "Rob"
                }
            ]
        }

        djangoClient = Client()

        response = djangoClient.post("/createRoom/", groupData, "application/json")

        print(response.json())

        self.assertEqual(response.json()["message"], "ohgod has been created")
        self.assertNotEqual(response.json()["date-time"], None)

        getResponse = djangoClient.get("/getUserRooms/2")

        print(getResponse.json())

        self.assertNotEqual(getResponse, None)
        self.assertNotEqual(getResponse.json()[0]["_id"], None)
        self.assertEqual(getResponse.json()[0]["groupName"], "ohgod")
        self.assertEqual(getResponse.json()[0]["invitedPeople"][0]["userID"], '2')
        self.assertEqual(getResponse.json()[0]["invitedPeople"][0]["name"], "Alex")
        self.assertEqual(getResponse.json()[0]["invitedPeople"][1]["userID"], "3")
        self.assertEqual(getResponse.json()[0]["invitedPeople"][1]["name"], "David")
        self.assertEqual(getResponse.json()[0]["invitedPeople"][2]["userID"], "4")
        self.assertEqual(getResponse.json()[0]["invitedPeople"][2]["name"], "Rob")