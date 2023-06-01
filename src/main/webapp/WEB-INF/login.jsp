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
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
	rel="stylesheet" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap"
	rel="stylesheet" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/re.css">
<title>Login</title>
</head>
<body>
	<section class="vh-100">
		<div class="container-fluid h-custom">
			<div
				class="row d-flex justify-content-center align-items-center h-100">

				<div class="di">
					<form:form action="/login" modelAttribute="newLogin" method="POST">


						<div class="form-outline mb-4">
						
						
						 
     
     
							<form:errors path="email" style="color:red;"/>
    
							<form:input path="email" type="email"
								class="form-control form-control-lg"
								placeholder="Enter a valid email address" />
							<form:label path="email">Email address</form:label>

						</div>


						<div class="form-outline mb-3">
							<form:errors path="password"  style="color:red;"/>
							<form:input path="password" type="password"
								class="form-control form-control-lg"
								placeholder="Enter password" />
							<form:label path="password">Password</form:label>
						</div>





						<div class="text-center text-lg-start mt-4 pt-2">
							<input type="submit" class="btn btn-primary btn-lg"
								style="padding-left: 2.5rem; padding-right: 2.5rem;"
								value="Login">
							<p class="small fw-bold mt-2 pt-1 mb-0">
								Don't have an account? <a href="/register" class="link-danger">Register</a>
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