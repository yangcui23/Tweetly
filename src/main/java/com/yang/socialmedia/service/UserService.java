package com.yang.socialmedia.service;


import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.yang.socialmedia.model.LoginUser;
import com.yang.socialmedia.model.User;
import com.yang.socialmedia.repository.UserRepository;

import jakarta.transaction.Transactional;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepository;

	public User register(User newUser, BindingResult result) {
		Optional<User> potentialUser = userRepository.findByEmail(newUser.getEmail());
		
		if (potentialUser.isPresent()) {
			result.rejectValue("email", "Unique", "This email is already in use!");
		}

		if (!newUser.getPassword().equals(newUser.getConfirm())) {
			result.rejectValue("confirm", "Matches", "Both passwords must match!");
		}

		if (result.hasErrors()) {
			return null;

		} else {
			String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
			newUser.setPassword(hashed);
			return userRepository.save(newUser);
		}
}
	public User login(LoginUser newLogin, BindingResult result) {

		if (result.hasErrors()) {
			return null;
		}

		Optional<User> potentialUser = userRepository.findByEmail(newLogin.getEmail());
		if (!potentialUser.isPresent()) {
			result.rejectValue("email", "Unique", "Unknown email!");
			return null;
		}

		User user = potentialUser.get();
		if (!BCrypt.checkpw(newLogin.getPassword(), user.getPassword())) {
			result.rejectValue("password", "Matches", "Invalid Password!");
		}

		if (result.hasErrors()) {
			return null;
		} else {
			return user;
		}
	}
	
	public List<User> allUsers() {
		return userRepository.findAll();
	}
	

	public User updateUser(User user) {
		return userRepository.save(user);
	}
	public User findById(Long id) {
		Optional<User> optionalUser = userRepository.findById(id);
		if (optionalUser.isPresent()) {
			return optionalUser.get();
		} else
			return null;
	}
	
	 public void followUser(Long followerId, Long userId) {
	        User follower = userRepository.findById(followerId).orElse(null);
	        User user = userRepository.findById(userId).orElse(null);

	        if (follower != null && user != null) {
	            follower.getFollowing().add(user);
	            userRepository.save(follower);
	        }
	    }

	 public void unfollowUser(Long followerId, Long userId) {
	        User follower = userRepository.findById(followerId).orElse(null);
	        User user = userRepository.findById(userId).orElse(null);

	        if (follower != null && user != null) {
	            follower.getFollowing().remove(user);
	            userRepository.save(follower);
	        }
	    }
    public List<User> getFollowers(Long userId) {
        return userRepository.findFollowersById(userId);
    }

    public List<User> getFollowing(Long userId) {
        return userRepository.findFollowingById(userId);
    }
    
    
    public List<User> searchUsers(String keyword) {
        return userRepository.findByUsernameContaining(keyword);
    }
}
