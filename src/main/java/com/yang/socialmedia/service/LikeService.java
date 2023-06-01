package com.yang.socialmedia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yang.socialmedia.model.Like;
import com.yang.socialmedia.model.Post;
import com.yang.socialmedia.model.User;
import com.yang.socialmedia.repository.LikeRepository;

import jakarta.transaction.Transactional;

@Service
public class LikeService {
	
	@Autowired
	private final LikeRepository likeRepository;
	
	public LikeService(LikeRepository likeRepository) {
        this.likeRepository = likeRepository;
    }

    public Long addLike(User user, Post post) {
    	Like like = new Like(user,post);
    	likeRepository.save(like);
    	
    	return likeRepository.countByPost(post);
    	
    }
    
    @Transactional
    public void deleteLike(User user,Post post) {
    	likeRepository.deleteByUsersAndPost(user, post);
    }
    
    public Boolean checkUserLiked(User user,Post post) {
    	 System.out.println("Checking user liked status for user: " + user.getId() + ", post: " + post.getId());
    	    
    	    boolean isLiked = likeRepository.existsByUsersAndPost(user, post);
    	    
    	    System.out.println("User liked status: " + isLiked);
    	    return isLiked;
    }
    
    public List<Post> findAllPostByUser(User user){
    	return likeRepository.findAllByUser(user);
    }
    
    public void deleteLikesByPost(Post post) {
        likeRepository.deleteByPost(post);
    }
}
