package com.yang.socialmedia.repository;


import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.yang.socialmedia.model.Comment;
import com.yang.socialmedia.model.Post;
import com.yang.socialmedia.model.User;

@Repository
public interface CommentRepository extends CrudRepository<Comment, Long>{
	
	Comment findByUserAndPosts(User user,Post posts);
	
	
	List<Comment> findByPosts(Post posts);
	
	void deleteByUserAndPosts(User user,Post posts);




	@Query("SELECT p from Post p,Comment c WHERE c.posts=p AND c.user =:user ")
	List<Post> findAllByUser(User user);
	
	void deleteByPosts(Post posts);
	
	
}
