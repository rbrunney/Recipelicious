package dngo.recipelicious;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserJPA extends JpaRepository<User, Long> {
}
