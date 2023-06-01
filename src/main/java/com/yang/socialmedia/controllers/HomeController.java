package com.yang.socialmedia.controllers;



import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yang.socialmedia.model.Comment;
import com.yang.socialmedia.model.Like;
import com.yang.socialmedia.model.Post;
import com.yang.socialmedia.model.User;
import com.yang.socialmedia.service.LikeService;
import com.yang.socialmedia.service.PostService;
import com.yang.socialmedia.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomeController {
		@Autowired
		private UserService userService;
		@Autowired
		private PostService postService;
		
		@Autowired
		private LikeService likeService;
		
		@GetMapping("/")
		public String home(Model model) {
			
			List<Post> posts = postService.allPosts();
			model.addAttribute("posts", posts);
			Collections.sort(posts, Comparator.comparing(Post::getCreatedAt).reversed());
			return "index.jsp";
		}
		
		
		
		@GetMapping("/user/{id}")
		public String profile(@PathVariable("id") Long id,Model model,
				HttpSession session) {
			Long userId = (Long) session.getAttribute("user_id");
			if(userId !=null) {
				User loggedUser = userService.findById(userId);
				User profileUser = userService.findById(id);
				List<User> usersList = userService.allUsers();
				
				model.addAttribute("usersList", usersList);
				List<Post> posts = profileUser.getPosts();
				Collections.sort(posts, Comparator.comparing(Post::getCreatedAt).reversed());
				List<Post> retweet = profileUser.getRetweet();
				List<Like> likedPosts = profileUser.getLikes();
				List<Comment> commentedPosts= profileUser.getComments();
				model.addAttribute("likedPosts", likedPosts);
				model.addAttribute("commentedPosts", commentedPosts);
				model.addAttribute("loggedUser", loggedUser);
				model.addAttribute("retweet", retweet);
				model.addAttribute("profileUser", profileUser);
				List<User> randomUsers = getRandomUsers(usersList, 3, loggedUser);
		        model.addAttribute("randomUsers", randomUsers);
				return "profile.jsp";
			}
			return "redirect:/login";
		}
		
		@GetMapping("/home")
		public String homePage(@ModelAttribute("post")Post post,Model model,HttpSession session,@RequestParam(required = false) String query) {
			Long userId = (Long) session.getAttribute("user_id");
			if(userId !=null) {
				
				
				User loggedUser = userService.findById(userId);
				List<User> user = userService.allUsers();
				List<User> randomUsers = getRandomUsers(user, 3, loggedUser);
				
				 model.addAttribute("likeService", likeService);
				
				model.addAttribute("user", user);
				
				model.addAttribute("randomUsers", randomUsers);
				model.addAttribute("loggedUser", loggedUser);
				if (query != null && !query.isEmpty()) {
		            List<Post> searchResults = postService.searchPosts(query);
		            model.addAttribute("posts", searchResults);
		        } else {
		            List<Post> posts = postService.allPosts();
		            Collections.sort(posts, Comparator.comparing(Post::getCreatedAt).reversed());
		            model.addAttribute("posts", posts);
		        }
				
				
				
				return "home.jsp";
			}
			return "redirect:/login";
			
		}
		
		@GetMapping("/search")
		public String search(@RequestParam("keyword") String keyword, Model model,HttpSession session) {
			Long userId = (Long) session.getAttribute("user_id");
			if(userId !=null) {
				User loggedUser = userService.findById(userId);
		  List<Post> posts = postService.searchPosts(keyword);
		  List<User> users = userService.searchUsers(keyword);
		  List<User> user = userService.allUsers();
		  List<User> randomUsers = getRandomUsers(user, 3, loggedUser);
		  boolean noPostResults = posts.isEmpty();
	        boolean noUserResults = users.isEmpty();
	        
		  model.addAttribute("posts", posts);
		  model.addAttribute("users", users);
		  model.addAttribute("loggedUser", loggedUser);
		  model.addAttribute("randomUsers", randomUsers);
		  model.addAttribute("keyword", keyword);
		  model.addAttribute("noPostResults", noPostResults);
	        model.addAttribute("noUserResults", noUserResults);
		  return "searchResult.jsp";
			}
			return "redirect:/login";
		}
		
		@PostMapping("/post")
		public String post(@Valid @ModelAttribute("post") Post post, BindingResult result,HttpSession session,Model model){
			Long userId = (Long) session.getAttribute("user_id");
			if(result.hasErrors()) {
				User loggedUser = userService.findById(userId);
		        model.addAttribute("loggedUser", loggedUser);
				return "home.jsp";
			}else {
				User loggedUser = userService.findById(userId);
				model.addAttribute("loggedUser", loggedUser);
				post.setUser(loggedUser);
				
				
				postService.addPost(post);
				return "redirect:/home";
				
			}
			
		}
		
		@PutMapping("/like/{id}")
		public String likePost(@PathVariable("id") Long id, HttpSession session) {
		    Long userId = (Long) session.getAttribute("user_id");
		    User user = userService.findById(userId);
		    Post post = postService.findById(id);

if(!likeService.checkUserLiked(user, post)) {
	        	
	        	likeService.addLike(user, post);
	        }else {
	        	likeService.deleteLike(user, post);
	        }
			postService.decrementViewCount(id);

       return String.format("redirect:/post/%s", post.getId());
		}
		
		@PutMapping("/posts/{id}/retweet")
		public String retweetPost(@PathVariable("id")Long id,
				HttpSession session) {
			Long userId = (Long) session.getAttribute("user_id");
			User retweet = userService.findById(userId);
			Post post = postService.findById(id);
			post.setRetweet(retweet);
			postService.addPost(post);
			return String.format("redirect:/user/%s", post.getUser().getId());
		}
		
		private List<User> getRandomUsers(List<User> usersList, int count, User loggedUser) {
		    
		    List<User> filteredList = new ArrayList<>(usersList);
		    filteredList.remove(loggedUser);

		   
		    Collections.shuffle(filteredList);

		  
		    int numUsers = Math.min(count, filteredList.size());
		    return filteredList.subList(0, numUsers);
		}
		
		@GetMapping("/checkLike")
		@ResponseBody
		public boolean checkLike(@RequestParam("postId") Long postId, HttpSession session) {
		    Long userId = (Long) session.getAttribute("user_id");
		    if (userId != null) {
		        User loggedUser = userService.findById(userId);
		        Post post = postService.findById(postId);
		        return likeService.checkUserLiked(loggedUser, post);
		    }
		    return false;
		}
		
		

}
