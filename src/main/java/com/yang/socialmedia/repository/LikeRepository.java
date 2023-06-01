package com.yang.socialmedia.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.yang.socialmedia.model.Like;
import com.yang.socialmedia.model.Post;
import com.yang.socialmedia.model.User;

@Repository
public interface LikeRepository extends CrudRepository<Like, Long>{
	Like findByUsersAndPost(User users, Post post);
	
	
	@Query("SELECT count(l) from Like l WHERE l.post=:post ")
	Long countByPost(Post post);
	
	
	
	void deleteByUsersAndPost(User users,Post post);
	
	
	Boolean existsByUsersAndPost(User users,Post post);
	
	
	@Query("SELECT p from Post p,Like l WHERE l.post=p AND l.users =:user ")
	List<Post> findAllByUser(User user);
	
	
	void deleteByPost(Post post);
	
}
