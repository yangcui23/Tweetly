<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<%@ page import="java.util.Collections"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/post.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/js/h.js"></script>
<title>Profile</title>
<style>
.input-wrapper {
	position: relative;
}

.counter {
	position: absolute;
	bottom: 50px;
	right: 10px;
	color: #999;
	font-size: 20px;
}

.counter.exceeded {
	color: red;
}

.toggle-container {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}
</style>
<script>
	function toggleEditButton() {
		var editBox = document.getElementById('editBox');
		editBox.style.display = editBox.style.display === 'none' ? 'block'
				: 'none';
	}

	document.addEventListener('DOMContentLoaded', function() {
		document.addEventListener('click', function(event) {
			var editBox = document.getElementById('editBox');
			var menuButton = document.querySelector('.menu-button');
			if (editBox.style.display === 'block'
					&& !editBox.contains(event.target)
					&& !menuButton.contains(event.target)) {
				editBox.style.display = 'none';
			}
		});
	});
	
	 $(document).ready(function() {
	        $('.like-form').submit(function(event) {
	            var form = $(this);
	            var button = form.find('.like-button');
	            var buttonText = button.text().trim();
	            
	            // Perform the AJAX request to submit the like
	            $.ajax({
	                url: form.attr('action'),
	                type: 'POST',
	                data: form.serialize(),
	                success: function(response) {
	                    // Update the button text based on the response
	                    if (buttonText === 'Like') {
	                        button.text('Liked');
	                        button.removeClass('like').addClass('liked');
	                    } else if (buttonText === 'Liked') {
	                        button.text('Like');
	                        button.removeClass('liked').addClass('like');
	                    }
	                },
	                error: function(error) {
	                    console.log('Error occurred during like/unlike request');
	                }
	            });
	            
	            event.preventDefault(); // Prevent the default form submission
	        });
	    });
</script>
</head>
<body>
	<div class="container d-flex w-75 border-top">
		<div class="leftCol">
			<a href="/" class="hover-shadow"><img class="img hover-shadow"
				src="https://static.vecteezy.com/system/resources/previews/002/534/045/original/social-media-twitter-logo-blue-isolated-free-vector.jpg"></a>
			<div class="b ">

				<a href="/home"
					class="setting d-flex align-items-center justify-content-around">
					<i class="bi bi-house-fill"></i>Home
				</a>
			</div>
			<div class="b">

				<a href="/user/${loggedUser.id}"
					class="setting d-flex align-items-center justify-content-around">
					<i class="bi bi-gear-wide-connected"></i>Profile
				</a>
			</div>
			<div class="b">

				<a href="/logout"
					class="setting d-flex align-items-center justify-content-around">
					<i class="bi bi-box-arrow-left"></i>Logout
				</a>
			</div>

		</div>






		<div class="contain w-50 border">
			<div class="rr">
				<a href="/home"><i class="bi bi-arrow-left"></i>Tweets</a>

			</div>
			<div class="border w-100 ">
				<div class="d-flex p-2 align-items-center justify-content-between">
					<div class="d-flex align-items-center">
						<img src=" ${post.user.photos}" class="userPhoto" />
						<p class="name">
							@<a href="/user/${post.user.id }" class="username" style="text-decoration:none;"><c:out
									value="${ post.user.username}" /></a>
						</p>


					</div>
					<c:if test="${post.user.id == loggedUser.id}">
						<div class="menu">
							<button class="menu-button" onclick="toggleEditButton()">
								...</button>
							<div class="edit-box" id="editBox">
								
								
									<form action="/posts/${post.id }" method="post" id="deleteForm_${post.id}" class="delete-form">
										 <input type="hidden" name="_method" value="DELETE">
										<button type="submit" class="edit-button">Delete</button>
									
									
									</form>
										
										
									
									
								
								


							</div>

						</div>
					</c:if>

				</div>
				<div class="content p-4">
					<p>
						<c:out value="${post.content }"></c:out>
					</p>


					<img src="${post.photos }" class="ww">

				</div>
				<div>
					<p class="date mt-3">
						<fmt:formatDate pattern="K:m a - MMM dd ,yyyy"
							value="${post.createdAt}" />
					</p>


				</div>
				<div class=" p-2 d-flex">
					<p class="ffo">
						<c:out value="${post.viewCount}"></c:out>
						<span class="likeCount">Views</span>
					</p>
					<div id="likeCountContainer">
    <p class="ffo">
        <span id="likeCount">${post.likes.size()}</span>
        <span class="likeCount">Likes</span>
    </p>
</div>
					<p>
						<c:out value="${post.comments.size()}"></c:out>
						<span class="likeCount">Comments</span>
					</p>
				</div>
				<div class="d-flex">
					<form action="/like/${post.id }" method="post">
						<input type="hidden" name="_method" value="put" /> <input
							type="hidden" name="postId" value="${post.id}" /> <input
							type="hidden" name="userId" value="${loggedUser.id}" />
						<button class="button-87" type="submit">Like</button>
					</form>
					<form action="/posts/${post.id}/retweet" method="post">
						<input type="hidden" name="_method" value="put" /> <input
							type="hidden" name="id" value="${post.id}" />

						<button type="submit" class="button-7">Retweet</button>

					</form>




				</div>
				<div class="commentInput d-flex border mt-3">
					<div>
						<img src="${loggedUser.photos}" class="log" />
					</div>
					<form:form action="/post/${post.id}/comment" method="post"
						modelAttribute="comment" class="form">

						<form:textarea path="content" placeholder="Add a comment..."
							style="resize: none;" class="commentContent" />

						<div class="d-flex">

							<form:input path="commentPhoto" id="info" placeholder="Image URL"
								style="display: none; height:30px ; margin-top:6px; margin-left:23px;" />
							<button id="toggleButton" role="button" class="button-70">
								<i class="bi bi-images"></i>
							</button>

							<button type="submit" class="button-29">reply</button>

						</div>


					</form:form>

				</div>
				<c:forEach var="comment" items="${postComments}">
					<div class="border w-100 d-flex">
						<div>
							<img src="${comment.user.photos }" class="log mt-3" />
						</div>
						<div class="ewd">
							<div>
								<p>
									@
									<a href="/user/${comment.user.id }" style="text-decoration:none;"><c:out value="${comment.user.username }"></c:out></a>
								</p>

							</div>

							<p>
								<c:out value="${comment.content}"></c:out>
							</p>
							<img src="${comment.commentPhoto}" class="commentPhoto" />

							<p class="mt-3">
								<fmt:formatDate pattern="K:m a - MMM dd ,yyyy"
									value="${comment.createdAt}" />
							</p>
						</div>




					</div>
				</c:forEach>

		


			</div>




		</div>

		<div class="rightCol p-5"></div>




	</div>
	<script>
		var contentTextarea = document.getElementById("content");
		var counterElement = document.getElementById("counter");
		var infoInput = document.getElementById("info");
		var toggleButton = document.getElementById("toggleButton");
		var postForm = document.getElementById("postForm");

		toggleButton.addEventListener("click", toggleInputVisibility);

		function toggleInputVisibility(e) {
			e.preventDefault();
			if (infoInput.style.display === "none") {
				infoInput.style.display = "block";
			} else {
				infoInput.style.display = "none";
			}
		}
		function toggleLike(postId) {
	        var likeButton = document.getElementById("likeButton");
	        var likeStatus = document.getElementById("likeStatus");
	        var likeCount = document.getElementById("likeCount");

	        // Make an AJAX request to toggle the like status
	        var xhr = new XMLHttpRequest();
	        xhr.open("PUT", "/like/" + postId);
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4) {
	                if (xhr.status === 200) {
	                    var response = JSON.parse(xhr.responseText);
	                    if (response.liked) {
	                        likeButton.classList.add("liked");
	                        likeButton.innerText = "Unlike";
	                        likeStatus.innerText = "Liked";
	                    } else {
	                        likeButton.classList.remove("liked");
	                        likeButton.innerText = "Like";
	                        likeStatus.innerText = "Unlike";
	                    }
	                    likeCount.innerText = response.likeCount;
	                } else {
	                    // Handle the error case
	                    console.error("Error: " + xhr.status);
	                }
	            }
	        };
	        xhr.send();
	    }
	</script>
</body>
</html>