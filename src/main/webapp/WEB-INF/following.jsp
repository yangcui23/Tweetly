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
<title>Following</title>
<script>
	
</script>
<style>
</style>
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
				<h3>
					<span> <c:out value="${user.username }" /></span> is Following
				</h3>

			</div>
			<div class=" border">
				<c:forEach var="follow" items="${following}">
					<div class="border d-flex justify-content-between p-3">
						<div>

							<img src="${follow.photos }" class="log">
						</div>

						<div class="de1">
							<a href="/user/${follow.id}">@ ${follow.username}</a>
							<p>${follow.location}</p>
						</div>


						<div class="ere">

							<form:form action="/user/${loggedUser.id}/unfollow/${follow.id}"
								method="post">
								<input type="hidden" name="_method" value="put" />
								<button class="button-85" role="button" type="submit">Unfollow</button>
							</form:form>



						</div>
					</div>


				</c:forEach>




			</div>

		</div>
		<div class="rightCol p-5">
			<div class="con border"></div>





		</div>


	</div>



</body>
</html>