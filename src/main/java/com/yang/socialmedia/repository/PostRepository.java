package com.yang.socialmedia.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.yang.socialmedia.model.Post;

@Repository
public interface PostRepository extends JpaRepository<Post, Long>{
	List<Post> findAll();
	 List<Post> findByContentContaining(String keyword);
	 
	 Optional<Post> findById(Long id);
	 
	 
	 
	 @Modifying
	    @Query("UPDATE Post p SET p.viewCount = COALESCE(p.viewCount, 0) + 1 WHERE p.id = :postId")
	    void incrementViewCount(@Param("postId") Long postId);
	 
	 
	 @Modifying
	 @Query("UPDATE Post p SET p.viewCount = COALESCE(p.viewCount, 0) - 1 WHERE p.id = :postId")
	 void decrementViewCount(@Param("postId") Long postId);
}
