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
<link rel="stylesheet" type="text/css" href="/css/home.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script type="text/javascript" src="/js/h.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

</script>
</head>
<body>

	<div class="container d-flex w-75 border-top">
		<div class="leftCol">
			<div>
			<a href="/home" class="hover-shadow"><img
				class="img hover-shadow"
				src="https://static.vecteezy.com/system/resources/previews/002/534/045/original/social-media-twitter-logo-blue-isolated-free-vector.jpg"></a>
			</div>
			<div class="b ">

				<a href="/home"
					class="setting d-flex align-items-center gap-5">
					<i class="bi bi-house-fill"></i>Home
				</a>
			</div>
			<div class="b ">

				<a href="/post/followed" class="setting d-flex align-items-center gap-5 ">
					<i class="bi bi-at"></i>Following
				</a>
			</div>
			<div class="b">

				<a href="/user/${loggedUser.id}"
					class="setting d-flex align-items-center gap-5">
					<i class="bi bi-gear-wide-connected"></i>Profile
				</a>
			</div>
			<div class="b">

				<a href="/logout"
					class="setting d-flex align-items-center gap-5">
					<i class="bi bi-box-arrow-left"></i>Logout
				</a>
			</div>

		</div>






		<div class="contain w-50  border">
			<div class="rr">
				<h3>Home</h3>

			</div>
			<div class="nav border">
				<div class="photo">
					<img src="${loggedUser.photos}" class="log">


				</div>
				<div class="form ">
					<form:form action="/post" method="POST" modelAttribute="post" id="postForm">
						<div class="input-wrapper">

							<form:textarea path="content" type="text"
								placeholder="What's happening?!" class="input" id="content"
								name="content" style="resize: none;" />

							<div id="counter" class="counter"></div>


						</div>
						<div class="d-flex mt-5 ">
							<form:input path="photos" id="info" placeholder="Image URL"
								style="display: none; height:30px ; margin-top:6px;" />
							<button id="toggleButton" role="button" class="button-70">
								<i class="bi bi-images"></i>
							</button>
							<button type="submit" class="button-71" role="button" disabled >Tweet</button>

						</div>

					</form:form>



				</div>
				<c:forEach var="posts" items="${posts}" varStatus="status">
					<div class="post d-flex  " id="post_${status.index}">
						<div class="d-flex flex-column  justify-content-between ">
							<div>
								<img src="${posts.user.photos}" class="log" />
							</div>
							<div class="connector"></div>






						</div>
						<div>
							<div class="name d-flex align-items-center justify-content-between">
								<div class="d d-flex align-items-center gap-2 ">
									<h4>
										@
										<a href="/user/${posts.user.id}" class="dewe"><c:out value="${posts.user.username }" /></a>
									</h4>
									<i class="bi bi-patch-check-fill"></i>


								<p class="date mt-3">
									<fmt:formatDate pattern="MMM dd ,yyyy"
										value="${posts.createdAt}" />
								</p>
								
								</div>
								
								
								
							</div>
							
							<div>
								<p class="qw">
									<c:out value="${posts.content}" />
								</p>
								
								 
        <img src="${posts.photos}" class="ew" />
      
							</div>
							<div class="dwwe d-flex mt-2">



								<p class="me-5">
									<c:out value="${posts.likes.size()}"></c:out>
									Likes
								</p>
								<p class="me-5">
									<c:out value="${posts.comments.size()}"></c:out>
									Comments
								</p>
								<p>
								
								<c:out value="${posts.viewCount }"></c:out>
									Views
								</p>




							</div>


						</div>
					</div>
					<div class="thread w-100 d-flex gap-5 ">
						<a href="/post/${posts.id}"
							class="lin d-flex gap-4 align-items-center"><img
							src="${posts.user.photos}" class="se" />Show this thread</a>
					</div>
				</c:forEach>



			</div>
			<div class="pic  d-flex"></div>

		</div>
		<div class="rightCol p-5">
			<div class="search">
			<form action="/search" method="get" class="search-form">
  <input name="keyword" class="search-input" type="text" placeholder="Search" value="${keyword }">
  <button type="submit" class="search-button"><i class="bi bi-search"></i></button>
</form>
			
			
			</div>
			
			
			<div class="con border">
				<c:set var="count" value="0" />

				<c:forEach var="post" items="${loggedUser.posts}" varStatus="status">
					<c:if test="${not empty post.photos && status.index < 6}">

						<a href="/post/${post.id}"><img src="${post.photos}"
							class="lay"></a>


					</c:if>
				</c:forEach>

			</div>

			<div class="all mt-5">
				<h3 class="might">You might like</h3>


				<c:forEach var="users" items="${randomUsers}" varStatus="status">
					<c:if
						test="${users.username ne loggedUser.username && status.index < 3 && !loggedUser.following.contains(users)}">
						<div
							class="o d-flex justify-content-between border align-items-center p-3">
							<img src="${users.photos}" class="user">
							<div>
								<a href="/user/${users.id}" class="userProfile">@<c:out
										value="${users.username}"></c:out></a>

							</div>
							<form:form action="/user/${loggedUser.id}/follow/${users.id}"
								method="post">
								<input type="hidden" name="_method" value="put" />
								<button class="button-85" role="button" type="submit">Follow</button>

							</form:form>

						</div>
					</c:if>

				</c:forEach>


			</div>


		</div>


	</div>



	<script>
		var contentTextarea = document.getElementById("content");
		var counterElement = document.getElementById("counter");
		var infoInput = document.getElementById("info");
		var toggleButton = document.getElementById("toggleButton");
		var postForm = document.getElementById("postForm");
		contentTextarea.addEventListener("input", updateCounter);
		toggleButton.addEventListener("click", toggleInputVisibility);

		function updateCounter() {
			var content = contentTextarea.value;
			var maxLength = 255;

			var count = content.length;
			var remaining = maxLength - count;

			counterElement.textContent = count + "/" + maxLength;

			
			if (count > maxLength) {
				counterElement.classList.add("exceeded");
			} else {
				counterElement.classList.remove("exceeded");
			}
		};
		function toggleInputVisibility(e) {
			e.preventDefault();
			if (infoInput.style.display === "none") {
				infoInput.style.display = "block";
			} else {
				infoInput.style.display = "none";
			}
		}
		var deleteForms = document.getElementsByClassName("delete-form");
	    Array.from(deleteForms).forEach(function(form) {
	        form.addEventListener("submit", function(event) {
	            event.preventDefault(); 

	            if (confirm("Are you sure you want to delete this post?")) {
	                var postId = form.id.split("_")[1]; 

	                
	                fetch("/posts/" + postId, {
	                    method: "DELETE"
	                })
	                .then(function(response) {
	                    if (response.ok) {
	                        
	                        location.reload();
	                    } else {
	                       
	                        console.error("Failed to delete the post.");
	                    }
	                })
	                .catch(function(error) {
	                    console.error("An error occurred while deleting the post:", error);
	                });
	            }
	        });
	    });
	    document.addEventListener("DOMContentLoaded", function() {
	        const textarea = document.getElementById('content');
	        const submitButton = document.querySelector('.button-71');

	        textarea.addEventListener('keyup', function() {
	          if (textarea.value.trim() !== '') {
	            submitButton.disabled = false;
	          } else {
	            submitButton.disabled = true;
	          }
	        });
	      });

	</script>


</body>
</html>