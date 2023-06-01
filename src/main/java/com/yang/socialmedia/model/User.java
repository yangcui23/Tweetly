package com.yang.socialmedia.model;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="users")
public class User {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	@NotEmpty(message="Username is required!")
    private String username;
	@NotEmpty(message="Email is required!")
    @Email(message="Please enter a valid email!")
    private String email;
	
	private String location;
	@Column(nullable = true, length = 500)
    private String photos;
	
	private String bio;
	@Column(nullable = true, length = 500)
    private String bgPhotos = "https://zebreus.github.io/all-gnome-backgrounds/images/adwaita-d-bce7dcb9a69f205d945eef7a34f1026e8dfd890e.webp";
	@NotEmpty(message="Password is required!")
    @Size(min=8, message="Password must be at least 8 characters")
    private String password;
	
	@Transient
    @NotEmpty(message="Confirm Password is required!")
    @Size(min=8, message="Confirm Password must be at least 8 characters")
    private String confirm;
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    
    @OneToMany(mappedBy="user", fetch = FetchType.LAZY)
    private List<Post> posts;
    
    @OneToMany(mappedBy="retweet",fetch = FetchType.LAZY)
    private List<Post> retweet;
    
    @OneToMany(mappedBy="users", fetch=FetchType.LAZY)
    private List<Like> likes;
    
    @OneToMany(mappedBy="user", fetch=FetchType.LAZY)
    private List<Comment> comments;
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "user_follows",
        joinColumns = @JoinColumn(name = "follower_id"),
        inverseJoinColumns = @JoinColumn(name = "followed_id")
    )
    private List<User> following;

    @ManyToMany(mappedBy = "following", fetch = FetchType.LAZY)
    private List<User> followers;
    
    public void follow(User userToFollow) {
        following.add(userToFollow);
        userToFollow.getFollowers().add(this);
    }

    public void unfollow(User userToUnfollow) {
        following.remove(userToUnfollow);
        userToUnfollow.getFollowers().remove(this);
    }
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
    
	public List<User> getFollowing() {
		return following;
	}

	public void setFollowing(List<User> following) {
		this.following = following;
	}

	public List<User> getFollowers() {
		return followers;
	}

	public void setFollowers(List<User> followers) {
		this.followers = followers;
	}

	public String getBgPhotos() {
		return bgPhotos;
	}
	public void setBgPhotos(String bgPhotos) {
		this.bgPhotos = bgPhotos;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	public String getPhotos() {
		return photos;
	}
	public void setPhotos(String photos) {
		this.photos = photos;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getConfirm() {
		return confirm;
	}
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	public List<Post> getPosts() {
		return posts;
	}
	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}
	public List<Like> getLikes() {
		return likes;
	}
	public void setLikes(List<Like> likes) {
		this.likes = likes;
	}
	
	public List<Post> getRetweet() {
		return retweet;
	}

	public void setRetweet(List<Post> retweet) {
		this.retweet = retweet;
	}

	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}
	
	
	
}
