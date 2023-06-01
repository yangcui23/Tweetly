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
<link rel="stylesheet" type="text/css" href="/css/pic.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script type="text/javascript" src="/js/js.js"></script>
<title>Profile</title>
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

				<a href="/home" class="setting d-flex align-items-center gap-5">
					<i class="bi bi-house-fill"></i>Home
				</a>
			</div>
			<div class="b ">

				<a href="/post/followed"
					class="setting d-flex align-items-center gap-5 "> <i
					class="bi bi-at"></i>Following
				</a>
			</div>
			<div class="b">

				<a href="/user/${loggedUser.id}"
					class="setting d-flex align-items-center gap-5"> <i
					class="bi bi-gear-wide-connected"></i>Profile
				</a>
			</div>
			<div class="b">

				<a href="/logout" class="setting d-flex align-items-center gap-5">
					<i class="bi bi-box-arrow-left"></i>Logout
				</a>
			</div>

		</div>






		<div class="contain w-50 d-flex flex-column border">
			<div class="rr"></div>

			<img src="${profileUser.bgPhotos}" class="bg" />


			<div class="pic d-flex">
				<div>

					<img src="${profileUser.photos}" class="imgd" />
					<p class="p">
						@
						<c:out value="${profileUser.username}"></c:out>
					</p>
					<p class="p">
						<c:out value="${profileUser.bio }"></c:out>
					</p>
					<div class="u d-flex gap-5">
						<p>
							<i class="bi bi-geo-alt-fill"></i>
							<c:out value="${profileUser.location}"></c:out>
						</p>
						<p>
							<i class="bi bi-calendar-week-fill"></i> Joined
							<fmt:formatDate pattern="MMM dd yyyy"
								value="${profileUser.createdAt}" />
						</p>

					</div>
					<div class="u d-flex gap-5">

						<a href="/user/${profileUser.id}/following" class="follow"><span
							class="me-2"><c:out
									value="${profileUser.following.size()}"></c:out></span>Following</a> <a
							href="/user/${profileUser.id}/followers" class="follow"><span
							class="me-2"><c:out
									value="${profileUser.followers.size()}"></c:out></span>Followers</a>

					</div>

				</div>
				<div class="iw p-4">
					<c:choose>
						<c:when test="${loggedUser.id == profileUser.id}">
							<a href="/user/${loggedUser.id}/edit" class="button-89">Edit
								Profile</a>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${profileUser.followers.contains(loggedUser)}">
									<form:form
										action="/user/${loggedUser.id}/unfollow/${profileUser.id}"
										method="post">
										<input type="hidden" name="_method" value="put" />
										<button class="button-85" role="button" type="submit">Unfollow</button>
									</form:form>
								</c:when>
								<c:otherwise>
									<form:form
										action="/user/${loggedUser.id}/follow/${profileUser.id}"
										method="post">
										<input type="hidden" name="_method" value="put" />
										<button class="button-85" role="button" type="submit">Follow</button>
									</form:form>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
			<div>
				<div class="tab">
					<button id="defaultOpen" class="tablinks border active"
						onclick="tabs(event, 'Tweets')">Tweets</button>
					<button class="tablinks border" onclick="tabs(event, 'Replies')">Replies</button>
					<button class="tablinks border" onclick="tabs(event, 'Likes')">Likes</button>
					<button class="tablinks border" onclick="tabs(event, 'Retweet')">Retweet</button>
				</div>

				<!-- Tab content -->
				<div id="Tweets" class="tabcontent show">


					<c:forEach var="posts" items="${profileUser.posts}">

						<div class="post d-flex  ">
							<div class="d-flex flex-column  justify-content-between ">
								<div>

									<img src="${posts.user.photos}" class="log" />
								</div>

								<div class="connector"></div>




							</div>
							<div>
								<div class="name d-flex align-items-center">
									<div class="d d-flex align-items-center gap-2">
										<h4>
											@
											<c:out value="${posts.user.username }" />
										</h4>
										<i class="bi bi-patch-check-fill"></i>


									</div>
									<p class="date mt-3">
										<fmt:formatDate pattern="MMM dd ,yyyy"
											value="${posts.createdAt}" />
									</p>
								</div>
								<div>
									<p class="qw">
										<c:out value="${posts.content}" />
									</p>
									<img src="${posts.photos} " class="ew">

								</div>

								<div class=" p-3 d-flex">
									<p class="ffo">
										<c:out value="${posts.likes.size()}"></c:out>
										<span class="likeCount">Likes</span>
									</p>

									<p class="ffo">
										<c:out value="${posts.comments.size()}"></c:out>
										<span class="likeCount">Comments</span>
									</p>
									<p>
										<c:choose>
											<c:when
												test="${posts.viewCount == null || posts.viewCount == 0}">
			0
		</c:when>
											<c:otherwise>
												<c:out value="${posts.viewCount}"></c:out>
											</c:otherwise>
										</c:choose>
										<span class="likeCount">Views</span>
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

				<div id="Replies" class="tabcontent">
					<c:forEach var="commentedPost" items="${commentedPosts}"
						varStatus="status">
						<c:if test="${status.first}">
							<div class="post d-flex ">
								<div class="d-flex flex-column  justify-content-between">
									<div>

										<img src="${commentedPost.posts.user.photos}" class="log" />
									</div>
									<div class="connector"></div>

								</div>
								<div>
									<div class="name d-flex align-items-center">
										<div class="d d-flex align-items-center gap-2">
											<h4>
												@
												<c:out value="${commentedPost.posts.user.username }" />
											</h4>
											<i class="bi bi-patch-check-fill"></i>


										</div>
										<p class="date mt-3">
											<fmt:formatDate pattern="MMM dd ,yyyy"
												value="${commentedPost.posts.createdAt}" />
										</p>
									</div>

									<div>
										<p class="qw">
											<c:out value="${commentedPost.posts.content}" />
										</p>
										<img src="${commentedPost.posts.photos} " class="ew">

									</div>
									<div class=" p-3 d-flex">
										<p class="ffo">
											<c:out value="${commentedPost.posts.likes.size()}"></c:out>
											<span class="likeCount">Likes</span>
										</p>

										<p class="ffo">
											<c:out value="${commentedPost.posts.comments.size()}"></c:out>
											<span class="likeCount">Comments</span>
										</p>
										<p>
										<c:choose>
											<c:when
												test="${commentedPost.posts.viewCount == null || commentedPost.posts.viewCount == 0}">
			0
		</c:when>
											<c:otherwise>
												<c:out value="${commentedPost.posts.viewCount}"></c:out>
											</c:otherwise>
										</c:choose>
										<span class="likeCount">Views</span>
									</p>
									</div>


								</div>

							</div>
							<div class="thread w-100 d-flex gap-5 ">
								<a href="/post/${commentedPost.posts.id}"
									class="lin d-flex gap-4 align-items-center"><img
									src="${commentedPost.posts.user.photos}" class="se" />Show
									this thread</a>
							</div>
							<c:forEach var="userComment"
								items="${commentedPost.posts.comments}">
								<c:if test="${userComment.user.id == profileUser.id}">
									<div class="border d-flex">

										<div>
											<img src="${ userComment.user.photos}" class="log">


										</div>

										<div>
											<div class="d-flex align-items-center gap-4 p-2">
												<p class="rwr">
													@
													<c:out value="${ userComment.user.username}"></c:out>
													<i class="bi bi-patch-check-fill"></i>
												</p>
												<p class="date">
													<fmt:formatDate pattern="MMM dd"
														value="${userComment.createdAt}" />
												</p>

											</div>
											<p class="trt">
												<c:out value="${userComment.content}" />
											</p>
											<img src="${userComment.commentPhoto} " class="ew" />


										</div>

									</div>

								</c:if>
							</c:forEach>




						</c:if>
					</c:forEach>
				</div>

				<div id="Likes" class="tabcontent">
					<c:forEach var="like" items="${likedPosts}">
						<div class="post d-flex  ">
							<div class="d-flex flex-column  justify-content-between">
								<div>

									<img src="${like.post.user.photos}" class="log" />

								</div>
								<div class="connector"></div>
							</div>
							<div>
								<div class="name d-flex align-items-center">
									<div class="d d-flex align-items-center gap-2">
										<h4>
											@
											<c:out value="${like.post.user.username }" />
										</h4>
										<i class="bi bi-patch-check-fill"></i>


									</div>
									<p class="date mt-3">
										<fmt:formatDate pattern="MMM dd ,yyyy"
											value="${like.post.createdAt}" />
									</p>
								</div>

								<div>
									<p class="qw">
										<c:out value="${like.post.content}" />
									</p>
									<img src="${like.post.photos} " class="ew">

								</div>
								<div class=" p-3 d-flex">
									<p class="ffo">
										<c:out value="${like.post.likes.size()}"></c:out>
										<span class="likeCount">Likes</span>
									</p>

									<p class="ffo">
										<c:out value="${like.post.comments.size()}"></c:out>
										<span class="likeCount">Comments</span>
									</p>
									<p>
										<c:choose>
											<c:when
												test="${like.post.viewCount == null || like.post.viewCount == 0}">
			0
		</c:when>
											<c:otherwise>
												<c:out value="${like.post.viewCount}"></c:out>
											</c:otherwise>
										</c:choose>
										<span class="likeCount">Views</span>
									</p>
								</div>


							</div>

						</div>
						<div class="thread w-100 d-flex gap-5 ">
							<a href="/post/${like.post.id}"
								class="lin d-flex gap-4 align-items-center"><img
								src="${like.post.user.photos}" class="se" />Show this thread</a>
						</div>



					</c:forEach>

				</div>
				<div id="Retweet" class="tabcontent">
					<c:forEach var="posts" items="${profileUser.retweet}">
						<div class="post d-flex  ">
							<div class="d-flex flex-column  justify-content-between ">
								<div>
									<img src="${posts.user.photos}" class="log" />

								</div>
								<div class="connector"></div>





							</div>
							<div>
								<div class="name d-flex align-items-center">
									<div class="d d-flex align-items-center gap-2">
										<h4>
											@
											<c:out value="${posts.user.username }" />
										</h4>
										<i class="bi bi-patch-check-fill"></i>


									</div>
									<p class="date mt-3">
										<fmt:formatDate pattern="MMM dd ,yyyy"
											value="${posts.createdAt}" />
									</p>
								</div>
								<div>
									<p class="qw">
										<c:out value="${posts.content}" />
									</p>
									<img src="${posts.photos} " class="ew">

								</div>
								<div class=" p-3 d-flex">
									<p class="ffo">
										<c:out value="${posts.likes.size()}"></c:out>
										<span class="likeCount">Likes</span>
									</p>

									<p class="ffo">
										<c:out value="${posts.comments.size()}"></c:out>
										<span class="likeCount">Comments</span>
									</p>
									<p>
										<c:choose>
											<c:when
												test="${posts.viewCount == null || posts.viewCount == 0}">
			0
		</c:when>
											<c:otherwise>
												<c:out value="${posts.viewCount}"></c:out>
											</c:otherwise>
										</c:choose>
										<span class="likeCount">Views</span>
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

			</div>



		</div>
		<div class="rightCol p-5">


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
		// Get the element with id "defaultOpen" and trigger a click event
		document.getElementById("defaultOpen").click();
	</script>
</body>
</html>