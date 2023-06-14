package dngo.recipelicious;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Service
public class UserBLL {

    //"Dependency injection is not recommended" yet! no one can agree on a proper alternative
    //so autowired it shall be
    @Autowired
    UserJPA userJPA;
    @Autowired
    UserRelationJPA userRelationJPA;

    public ResponseEntity<Map<String, Object>> addFriend(Long idOfRequestingUser, Long idOfFriend){
        User requestingUser = userJPA.findById(idOfRequestingUser).orElse(null);
        User friendUser = userJPA.findById(idOfFriend).orElse(null);

        if(requestingUser == null || friendUser == null){
//            throw new IllegalArgumentException("Either one of the supplied users does not exist in database!");

            Map<String, Object> response = new HashMap<>();

            response.put("message", "Invalid user supplied!");
            response.put("user1", requestingUser);
            response.put("user2", friendUser);
            response.put("date-time", LocalDateTime.now().toString());

            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        }

        UserRelation relation = new UserRelation();

        relation.setFirstUser(requestingUser);
        relation.setSecondUser(friendUser);

        requestingUser.getFriendsTo().add(relation);

        friendUser.getFriendsFrom().add(relation);

        userJPA.saveAllAndFlush(new ArrayList<User>(){
            {add(requestingUser); add(friendUser);}
        });

        userRelationJPA.saveAndFlush(relation);

        Map<String, Object> response = new HashMap<>();

        response.put("message", "Friendship created");
        response.put("user1", requestingUser);
        response.put("user2", friendUser);
        response.put("date-time", LocalDateTime.now().toString());


        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
