<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Search result</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/home.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script type="text/javascript" src="/js/h.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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






		<div class="contain w-50  border">
			<div class="rr">
				<form action="/search" method="get" class="search-form">
					<input name="keyword" class="search-input" type="text"
						placeholder="Search" value="${keyword }">
					<button type="submit" class="search-button">
						<i class="bi bi-search"></i>
					</button>
				</form>

			</div>
				<div class="tabs">
					<button class="tablinks active" onclick="openTab(event, 'postTab')">Posts</button>
					<button class="tablinks" onclick="openTab(event, 'userTab')">Users</button>
				</div>
			<div class="nav border">

				<div id="postTab" class="tabcontent">
				<c:if test="${noPostResults}">
					<div class="noResult w-100 p-4">
    <p>No posts found for your search keyword.</p>
				</div>
</c:if>
					<c:forEach var="posts" items="${posts}" varStatus="status">
						<div class="post d-flex  " id="post_${status.index}">
							<div class="d-flex flex-column  justify-content-between ">
								<div>
									<img src="${posts.user.photos}" class="log" />
								</div>
								<div class="connector"></div>






							</div>
							<div>
								<div
									class="name d-flex align-items-center justify-content-between">
									<div class="d d-flex align-items-center gap-2 ">
										<h4>
											@ <a href="/user/${posts.user.id}" class="dewe"><c:out
													value="${posts.user.username }" /></a>
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
										<script>
											var postContent = "${posts.content}";
											var searchWord = "${keyword}";

											var escapedContent = postContent
													.replace(/"/g, '&quot;');

											var boldContent = escapedContent
													.replace(new RegExp(
															searchWord, 'gi'),
															'<strong>$&</strong>');

											document.write(boldContent);
										</script>
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

				<div id="userTab" class="tabcontent">
				
				<c:if test="${noUserResults}">
				<div class="noResult w-100 p-4">
    <p>No users found for your search keyword.</p>
				</div>
</c:if>
					<c:forEach var="user" items="${users}">
						<div class="htj border d-flex p-3">
							<div>

								<img src="${user.photos }" class="log">
							</div>

							<div class="de1">
								<a href="/user/${user.id}">@ ${user.username}</a>
								<p>${user.location}</p>
							</div>
							<div class="ew4">
								<c:choose>
									<c:when test="${loggedUser.following.contains(user)}">
										<form:form action="/user/${loggedUser.id}/unfollow/${user.id}"
											method="post">
											<input type="hidden" name="_method" value="put" />
											<button class="button-85" role="button" type="submit">Unfollow</button>
										</form:form>
									</c:when>
									<c:otherwise>
										<form:form action="/user/${loggedUser.id}/follow/${user.id}"
											method="post">
											<input type="hidden" name="_method" value="put" />
											<button class="button-85" role="button" type="submit">Follow</button>
										</form:form>
									</c:otherwise>
								</c:choose>


							</div>


						</div>


					</c:forEach>
				</div>






			</div>
			<div class="pic  d-flex"></div>

		</div>
		<div class="rightCol p-5">
		

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
		function openTab(event, tabName) {
			// Get all tab content elements
			var tabContent = document.getElementsByClassName("tabcontent");

			// Hide all tab content elements
			for (var i = 0; i < tabContent.length; i++) {
				tabContent[i].style.display = "none";
			}

			// Get all tab links elements
			var tabLinks = document.getElementsByClassName("tablinks");

			// Remove "active" class from all tab links
			for (var i = 0; i < tabLinks.length; i++) {
				tabLinks[i].className = tabLinks[i].className.replace(
						" active", "");
			}

			// Show the selected tab content and mark the tab link as active
			document.getElementById(tabName).style.display = "block";
			event.currentTarget.className += " active";
		}

		// Set the "Posts" tab as the default active tab
		document.getElementById("postTab").style.display = "block";
		document.getElementsByClassName("tablinks")[0].className += " active";

		document.getElementById("searchBar").value = "${keyword}";
	</script>
</body>
</html>