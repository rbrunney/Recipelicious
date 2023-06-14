package dngo.recipelicious;


import jakarta.persistence.*;

import java.util.Set;

@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="user_id")
    private Long id;

    @OneToMany(mappedBy = "firstUser", fetch = FetchType.LAZY)
    private Set<UserRelation> friendsTo;

    @OneToMany(mappedBy = "secondUser", fetch = FetchType.LAZY)
    private Set<UserRelation> friendsFrom;

    private String username;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Set<UserRelation> getFriendsTo() {
        return friendsTo;
    }

    public void setFriendsTo(Set<UserRelation> friendsTo) {
        this.friendsTo = friendsTo;
    }

    public Set<UserRelation> getFriendsFrom() {
        return friendsFrom;
    }

    public void setFriendsFrom(Set<UserRelation> friendsFrom) {
        this.friendsFrom = friendsFrom;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }
}
