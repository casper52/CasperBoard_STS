<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en" class="body-full-height">
<head>
<!-- META SECTION -->
<title>Casper Board</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />


<!-- END META SECTION -->

<!-- CSS INCLUDE -->
<link rel="stylesheet" type="text/css" id="theme"
	href="/resources/css/theme-default.css" />
<!-- EOF CSS INCLUDE -->
</head>
<body>


	<div class="login-container">

		<div class="login-box animated fadeInDown">
			<div class="login-logo"></div>
			<div class="login-body">
				<div class="login-title">
					<strong>Welcome</strong>, Please login
				</div>
				<form action="/login" class="form-horizontal" method="post">
					<div class="form-group">
						<div class="col-md-12">
							<input type="text" class="form-control" placeholder="Username"
								name="username" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12">
							<input type="password" class="form-control"
								placeholder="Password" name="password" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-6">
							<input type='checkbox' name='remember-me'><font color=white>　Remember Me</font>
						</div>
						<div class="col-md-6">
							<a href="/board/list"><button class="btn btn-info btn-block">Log In</button></a>
						</div>
					
					</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form>
			</div>
			<div class="login-footer">
				<div class="pull-left">&copy; 2014 AppName</div>
				<div class="pull-right">
					<a href="/casper/signUp">Sign Up</a> 
				</div>
			</div>
		</div>

	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
<script>
		$(".btn-info").on("click", function(e) {
			e.preventDefault();
			$("form").submit();
			console.log("login clicked....")
		})
		
		$(".btn-success").on("click", function(e) {
			e.preventDefault();
			$("form").submit();
			console.log("signup clicked....")
		})
		
	</script>
	
</body>
</html>
