package com.yang.socialmedia.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yang.socialmedia.model.Post;
import com.yang.socialmedia.repository.CommentRepository;
import com.yang.socialmedia.repository.LikeRepository;
import com.yang.socialmedia.repository.PostRepository;

import jakarta.transaction.Transactional;


@Service
public class PostService {
	@Autowired
	private PostRepository postRepository;
	private final CommentRepository commentRepository;
    private final LikeRepository likeRepository;
    public PostService(PostRepository postRepository, CommentRepository commentRepository, LikeRepository likeRepository) {
        this.postRepository = postRepository;
        this.commentRepository = commentRepository;
        this.likeRepository = likeRepository;
    }
	

	
	public List<Post> allPosts(){
		return postRepository.findAll();
	}
	public Post addPost(Post post) {
		
		return postRepository.save(post);
	}
	@Transactional
	public void deletePostById(Long postId) {
        Optional<Post> optionalPost = postRepository.findById(postId);
        if (optionalPost.isPresent()) {
            Post post = optionalPost.get();

            // Delete the comments associated with the post
            commentRepository.deleteByPosts(post);

            // Delete the likes associated with the post
            likeRepository.deleteByPost(post);

            // Delete the post
            postRepository.delete(post);
        } else {
            // Handle the case when the post is not found
            // You can throw an exception, return an error message, etc.
        }
    }
	
	public Post findById(Long id) {
		Optional<Post> optionalPost = postRepository.findById(id);
		if(optionalPost.isPresent()) {
			return optionalPost.get();
		}else {
			return null;
		}
	}
	
	
	
	@Transactional
    public void incrementViewCount(Long postId) {
        postRepository.incrementViewCount(postId);
    }
	@Transactional
	public void decrementViewCount(Long postId) {
		postRepository.decrementViewCount(postId);
	}
	
	public List<Post> searchPosts(String keyword) {
        return postRepository.findByContentContaining(keyword);
    }
}
