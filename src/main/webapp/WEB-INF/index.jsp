<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" />
	<link rel="stylesheet" type="text/css" href="/css/home.css">
<title>Explore</title>
</head>
<body>
	<div class="container w-75 d-flex">
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
			
		</div>
		<div class="mid w-50 border">
			<div class="rr">
				<h3>Explore</h3>
				
			</div>
			<div class="nav border">
				
				
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
										<c:out value="${posts.user.username }" />
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
								
								<img src="${posts.photos}"  class="ew" />
							</div>
							<div class="dwwe d-flex mt-2">



								<p class="me-5">
									<c:out value="${posts.likes.size()}"></c:out>
									Likes
								</p>

								<p>
									<c:out value="${posts.comments.size()}"></c:out>
									Comments
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
		
		
		<div class="rightCol">
			<div class="log-nav border">
				<h3 class="font font-weight-bold">New to Twitter?</h3>
				<p>Sign up now to get your own timeline!!</p>
				<div class="c text-center">
				
				<a href="/register" class="create ">Create Account</a>
				
				</div>
				<div class="c text-center">
				
				<a href="/login" class="create ">Login Account</a>
				
				</div>
				
			</div>
		
		
		</div>


	</div>
</body>
</html>