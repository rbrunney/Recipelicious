package dngo.recipelicious;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @RequestMapping(value = "/deleteFriendship", method = RequestMethod.DELETE)
    public ResponseEntity<Map<String, Object>> deleteFriendship(@RequestBody JsonNode userIds){
        Long userOneId = userIds.get("user1").asLong();
        Long userTwoId = userIds.get("user2").asLong();

        return userBLL.removeFriend(userOneId, userTwoId);
    }

    @RequestMapping(value = "/getUserFriendships", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> getUserFriendships(@RequestParam Long userId){
        return userBLL.getFriendships(userId);
    }




}
