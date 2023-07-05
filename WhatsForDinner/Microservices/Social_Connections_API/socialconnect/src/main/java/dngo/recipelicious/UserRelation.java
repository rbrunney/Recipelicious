package dngo.recipelicious;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerator;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;

@Entity
//@JsonIdentityInfo(property = "id", generator = ObjectIdGenerators.PropertyGenerator.class)
public class UserRelation {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name="first_user_id", nullable = false, referencedColumnName = "user_id")
    private User firstUser;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name="second_user_id", nullable = false, referencedColumnName = "user_id")
    private User secondUser;

    public User getFirstUser() {
        return firstUser;
    }

    public void setFirstUser(User firstUser) {
        this.firstUser = firstUser;
    }

    public User getSecondUser() {
        return secondUser;
    }

    public void setSecondUser(User secondUser) {
        this.secondUser = secondUser;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    @Override
    public String toString(){
        return "User1:{" + firstUser.getId() + "," + firstUser.getUsername() + "}, User2:{" + secondUser.getId() + "," + secondUser.getUsername() + "}";
    }


}
