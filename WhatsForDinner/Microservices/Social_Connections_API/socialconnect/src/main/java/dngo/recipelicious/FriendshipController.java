package dngo.recipelicious;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/friends")
public class FriendshipController {

    @Autowired
    UserBLL userBLL;

    @RequestMapping(value = "/addFriendship", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> addFriendShip(@RequestBody JsonNode userIds){

        Long userOneId = userIds.get("user1").asLong();
        Long userTwoId = userIds.get("user2").asLong();

        return userBLL.addFriend(userOneId, userTwoId);
    }



}
