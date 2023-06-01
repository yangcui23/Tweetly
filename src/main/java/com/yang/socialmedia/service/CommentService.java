package com.yang.socialmedia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yang.socialmedia.model.Comment;
import com.yang.socialmedia.model.Post;
import com.yang.socialmedia.model.User;
import com.yang.socialmedia.repository.CommentRepository;

import jakarta.transaction.Transactional;

@Service
public class CommentService {
			@Autowired
			private final CommentRepository commentRepository;
			
			
			public CommentService(CommentRepository commentRepository) {
				this.commentRepository = commentRepository;
			}
			
			
			public Comment addComment(Comment comment) {
				
				
				return commentRepository.save(comment);
			}
			
			
			@Transactional
		    public void removeComment(User user,Post posts) {
		    	commentRepository.deleteByUserAndPosts(user, posts);
		    }
			
			public List<Post> findAllPostByUser(User user){
		    	return commentRepository.findAllByUser(user);
		    }
			
			public List<Comment> getCommentsByPost(Post posts) {
		        return commentRepository.findByPosts(posts);
		    }
			public void deleteComment(Long commentId) {
		        commentRepository.deleteById(commentId);
		    }

		    public void deleteCommentsByPost(Post posts) {
		        commentRepository.deleteByPosts(posts);
		    }
			
}
