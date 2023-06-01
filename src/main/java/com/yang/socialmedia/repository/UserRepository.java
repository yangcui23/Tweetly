package com.yang.socialmedia.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.yang.socialmedia.model.User;


@Repository
public interface UserRepository  extends CrudRepository<User , Long> {
	List<User> findAll();
	
	Optional<User> findByEmail(String email);
	
	@Query("SELECT u.followers FROM User u WHERE u.id = :userId")
    List<User> findFollowersById(@Param("userId") Long userId);
    
    @Query("SELECT u.following FROM User u WHERE u.id = :userId")
    List<User> findFollowingById(@Param("userId") Long userId);
    
    List<User> findByUsernameContaining(String keyword);
}
