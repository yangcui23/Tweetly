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

				<a href="/user/${user.id}"
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
				<h3><c:out value="${user.username}"></c:out></h3>

			</div>
			<div class="nav border">
				<div class="photo">
					<img src="${user.photos}" class="log">


				</div>
				<div class="form ">
				<form:form action="/user/${user.id}/edit" method="post" modelAttribute="user">
					<input type="hidden" name="_method" value="put">
					<input
										type="hidden" name="id" value="${user.id}" />
					<div class="w-50 mt-3">
					<form:label path="bio" >Change your bio</form:label>
					<form:textarea type="text" path="bio" placeholder="Put something in here for your bio" class="text form-control" style="resize: none;"/>
					
					
					</div>
					<div class="w-50 mt-3">
					<form:label path="photos">Change your profile pic</form:label>
					<form:input type="text" path="photos" placeholder="Image URL" class="form-control"/>
					
					
					</div>
					<div class="w-50 mt-3">
					<form:label path="bgPhotos">Change your banner image</form:label>
					<form:input type="text" path="bgPhotos" placeholder="Image URL" class="form-control"/>
					
					
					</div>
					<div class="w-50 mt-3">
					<form:label path="location">Change your location</form:label>
					<form:input type="text" path="location" placeholder="Image URL" class="form-control"/>
					
					
					</div>
					<form:input type="hidden" path="username"/>
					<form:input type="hidden" path="email"/>
					<form:input type="hidden" path="password"/>
					<form:input type="hidden" path="confirm" value="dwadwad"/>
				
					<input type="submit" value="Save"/>
				</form:form>
					



				</div>
				


			</div>
			<div class="pic  d-flex"></div>

		</div>
		<div class="rightCol p-5">
			<div class="con border">
				

			</div>

			<div class="all mt-5">
				


				

				


			</div>


		</div>


	</div>




</body>
</html>