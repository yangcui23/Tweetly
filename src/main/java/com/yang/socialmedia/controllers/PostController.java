package com.yang.socialmedia.controllers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.yang.socialmedia.model.Comment;
import com.yang.socialmedia.model.Post;
import com.yang.socialmedia.model.User;
import com.yang.socialmedia.service.CommentService;
import com.yang.socialmedia.service.LikeService;
import com.yang.socialmedia.service.PostService;
import com.yang.socialmedia.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class PostController {
	@Autowired
	private UserService userService;
	@Autowired
	private PostService postService;
	
	@Autowired
	private LikeService likeService;
	@Autowired
	private CommentService commentService;
	
	@GetMapping("/post/{id}")
	public String post(@PathVariable("id") Long id,@ModelAttribute("comment") Comment comment,Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("user_id");
		if(userId !=null) {
			User loggedUser = userService.findById(userId);
			Post post = postService.findById(id);
			List<Comment> postComments = post.getComments();
			model.addAttribute("comment",comment);
			model.addAttribute("postComments", postComments);
			model.addAttribute("loggedUser", loggedUser);
			model.addAttribute("post", post);

			postService.incrementViewCount(id);
			return "viewPost.jsp";
			
		}
		return "redirect:/login";
	}
	
	
	@PostMapping("/post/{id}/comment")
	public String addPost(@PathVariable("id")Long id,@ModelAttribute("comment") Comment comment,HttpSession session,BindingResult result) {
		Long userId = (Long) session.getAttribute("user_id");
		if(result.hasErrors()) {
			return "viewPost.jsp";
		}
        User user = userService.findById(userId);
        Post post = postService.findById(id);
        System.out.println(comment.getContent());
        comment.setUser(user);
        comment.setPosts(post);
        comment.setId(null);
        commentService.addComment(comment);
        return "viewPost.jsp";
	}
	
	@DeleteMapping("/posts/{postId}")
	public String deletePost(@PathVariable("postId") Long postId) {
	    postService.deletePostById(postId);
	    return "redirect:/home";
	}
	
	@GetMapping("/post/followed")
	public String folloedUserPosts(@ModelAttribute("post")Post post,Model model,HttpSession session) {
		Long userId = (Long) session.getAttribute("user_id");
		if(userId !=null) {
			
			User loggedUser = userService.findById(userId);
			List<Post> followedPosts = new ArrayList<>();
	        for (User followedUser : loggedUser.getFollowing()) {
	            followedPosts.addAll(followedUser.getPosts());
	        }
	        Collections.sort(followedPosts, Comparator.comparing(Post::getCreatedAt).reversed());
	        List<User> randomUsers = getRandomUsers(userService.allUsers(), 3, loggedUser);
	        model.addAttribute("posts", followedPosts);
	        model.addAttribute("randomUsers", randomUsers);
	        model.addAttribute("loggedUser", loggedUser);
			return "followedPost.jsp";
		}
		return "redirect:/login";
		
	}
	private List<User> getRandomUsers(List<User> usersList, int count, User loggedUser) {
	    
	    List<User> filteredList = new ArrayList<>(usersList);
	    filteredList.remove(loggedUser);

	   
	    Collections.shuffle(filteredList);

	  
	    int numUsers = Math.min(count, filteredList.size());
	    return filteredList.subList(0, numUsers);
	}
}
