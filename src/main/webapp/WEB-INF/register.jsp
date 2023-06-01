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
<title>Register</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
	rel="stylesheet" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap"
	rel="stylesheet" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/re.css">
</head>
<body>
	<section class="vh-100">
		<div class="container-fluid h-custom">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				
				<div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1 mt-5">
					<form:form action="/register" modelAttribute="newUser" method="POST">
						<div class="form-outline mb-4">
							<form:errors path="username" style="color:red;"/>
							<form:input path="username" type="text"
								class="form-control form-control-lg"
								placeholder="Enter username" />
							<form:label path="email">Username</form:label>
						</div>
						<div class="form-outline mb-4">
						
							<form:input path="location" type="text"
								class="form-control form-control-lg"
								placeholder="Where ya at?" />
							<form:label path="location">Where are you from?</form:label>
						</div>
						<div class="form-outline mb-4">
							<form:label path="photos" >Pick 1, this is for your default PFP</form:label>
							<form:select path="photos">
								<option value="https://i.pinimg.com/736x/85/76/b9/8576b9b3558132762f387f216b9495e9.jpg">Male</option>
								<option value="https://favim.com/pd/s11/orig/8/882/8824/88245/default-twitter-default-pfp-Favim.com-8824594.png">Female</option>
								<option value="https://i.pinimg.com/736x/d0/9b/bd/d09bbd8e98ebaa93996fb4c059d294af.jpg">Other</option>
								
							
							
							
							</form:select>
							
						</div>
						
						

						
						<div class="form-outline mb-4">
							<form:errors path="email" style="color:red;"/>
							<form:input path="email" type="email"
								class="form-control form-control-lg"
								placeholder="Enter a valid email address" />
							<form:label path="email">Email address</form:label>
						</div>

						
						<div class="form-outline mb-3">
						<form:errors path="password" style="color:red;"/>
							<form:input path="password" type="password" class="form-control form-control-lg"
								placeholder="Enter password" /> <form:label path="password">Password</form:label>
						</div>
						<div class="form-outline mb-3">
						<form:errors path="confirm" style="color:red;"/>
							<form:input path="confirm" type="password" class="form-control form-control-lg"
								placeholder="Enter password again" /> <form:label path="confirm">Confirm Password</form:label>
						</div>
						
						
						
						

						<div class="text-center text-lg-start mt-4 pt-2">
							<input class="btn btn-primary btn-lg"
								style="padding-left: 2.5rem; padding-right: 2.5rem;" type="submit" value="Register">
							<p class="small fw-bold mt-2 pt-1 mb-0">
								Already have a account? <a href="/login" class="link-danger">Login</a>
							</p>
						</div>

					</form:form>
				</div>
			</div>
		</div>
		<div
			class="bot d-flex flex-column flex-md-row text-center text-md-start justify-content-between py-4 px-4 px-xl-5 bg-primary">
			<div class="text-white mb-3 mb-md-0">Copyright © 2023. All
				rights reserved.</div>
			<div>
				<a href="https://github.com/yangcui23" class="text-white me-4"> <i class="fab fa-github"></i>
				</a> <a href="https://www.linkedin.com/in/yang-cui-477127266/" class="text-white"> <i class="fab fa-linkedin-in"></i>
				</a>
			</div>

		</div>
	</section>
</body>
</html>