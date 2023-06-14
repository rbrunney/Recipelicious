package dngo.recipelicious;

import jakarta.persistence.*;

@Entity
public class UserRelation {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne
    @JoinColumn(name="first_user_id", nullable = false, referencedColumnName = "user_id")
    private User firstUser;

    @ManyToOne
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
}
