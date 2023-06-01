package com.yang.socialmedia.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.yang.socialmedia.model.LoginUser;
import com.yang.socialmedia.model.User;

import com.yang.socialmedia.service.LikeService;
import com.yang.socialmedia.service.PostService;
import com.yang.socialmedia.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {
	@Autowired
	private UserService userService;

	
	
	@GetMapping("/register")
	public String register(Model model) {
		model.addAttribute("newUser", new User());
		
		return "register.jsp";
	}
	@GetMapping("/login")
	public String login(Model model) {
		
		model.addAttribute("newLogin", new LoginUser());
		return "login.jsp";
	}
	
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model,
			HttpSession session) {
		userService.register(newUser, result);
		if (result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "register.jsp";
		}
		session.setAttribute("user_id", newUser.getId());
		return "redirect:/home";
	}

	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model,
			HttpSession session) {

		User user = userService.login(newLogin, result);
		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "login.jsp";
		}
		session.setAttribute("user_id", user.getId());
		return "redirect:/home";
	}
	
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
	@GetMapping("/user/{id}/edit")
	public String editUser(@PathVariable("id")Long id,Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("user_id");
		if (userId != null) {
			User user = userService.findById(userId);
			model.addAttribute("user",user);
		}
		
		return "editUser.jsp";
	}
	
	
	@PutMapping("/user/{id}/edit")
	public String edit(@ModelAttribute("user")User user,Model model) {
		System.out.println("test");
			user.setConfirm("testtest");
			
			userService.updateUser(user);
		    return "redirect:/home";
	}
	
	@PutMapping("/user/{followerId}/follow/{userId}")
	public String followUser(@PathVariable("followerId") Long followerId, @PathVariable("userId") Long userId) {
	    userService.followUser(followerId, userId);
	    return "redirect:/user/{userId}";
	}
	@PutMapping("/user/{followerId}/unfollow/{userId}")
	public String unfollowUser(@PathVariable("followerId") Long followerId, @PathVariable("userId") Long userId) {
	    userService.unfollowUser(followerId, userId);
	    return "redirect:/home";
	}
	
	
	
	
	@GetMapping("/user/{id}/followers")
	public String getFollowers(@PathVariable("id") Long id, Model model,HttpSession session) {
		Long userId = (Long) session.getAttribute("user_id");
		User loggedUser = userService.findById(userId);
		User user = userService.findById(id);
	    List<User> followers = user.getFollowers();
	    model.addAttribute("user", user);
	    model.addAttribute("followers", followers);
	    model.addAttribute("loggedUser",loggedUser);
	    
	    
	    return "followers.jsp"; 
	}
	@GetMapping("/user/{id}/following")
	public String getFollowing(@PathVariable("id") Long id, Model model,HttpSession session) {
		Long userId = (Long) session.getAttribute("user_id");
		User loggedUser = userService.findById(userId);
		User user = userService.findById(id);
		List<User> following = user.getFollowing();
		model.addAttribute("user", user);
		model.addAttribute("following", following);
		model.addAttribute("loggedUser",loggedUser);
		
		return "following.jsp"; 
	}
	
	
	
}
