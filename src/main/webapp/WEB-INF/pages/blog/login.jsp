<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="lazyrabbit">
<link rel="icon" type="image/png" sizes="96x96" href="../images/carrot03.png">

<title>lazyrabbit's home</title>
<link href="https://cdn.bootcss.com/twitter-bootstrap/4.2.1/css/bootstrap.min.css" rel="stylesheet">
<link href="../css/login.css" rel="stylesheet">
</head>
<body class="text-center">
	<form class="form-signin" id="loginform" action="${pageContext.request.contextPath }/login/check">
		<!-- 		<img class="mb-4" src="../images/2ha.jpg" alt="" width="72" height="72"> -->
		<h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
		<label for="inputEmail" class="sr-only">Email address</label>
		<input type="text" name="accountname" id="accountname" class="form-control" placeholder="Name" required autofocus>
		<label for="inputPassword" class="sr-only">Password</label>
		<input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
		<div class="checkbox mb-3" ">
<!-- 			<label > -->
<!-- 				<input type="checkbox" value="remember-me"> -->
<!-- 				Remember me -->
<!-- 			</label> -->
			<label>
			<span id="message" style="color: red;" ></span>
			</label>
		</div>
<!-- 		<div style="margin-top: 0px; text-align: left; color: red; height: 20px;"> -->
<!-- 			<span id="message"></span> -->
<!-- 		</div> -->
		<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
		<p class="mt-5 mb-3 text-muted">&copy; 2018-2019</p>
	</form>
</body>
<script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery.form/4.2.2/jquery.form.js"></script>
<script src="https://cdn.bootcss.com/twitter-bootstrap/4.2.1/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	$(function() {
		var options = {
			beforeSubmit : showRequest, // pre-submit callback 
			success : showResponse, // post-submit callback 
			dataType : "json",
			resetForm : false
		};
		$('#loginform').ajaxForm(options);

	});
	function showRequest() {
		        var accountname = $("#accountname").val();
		        var password = $("#password").val();
		        if ($.trim(accountname) == "") {
		            $("#message").html("请输入用户名！");
		            return false;
		        } else if ($.trim(password) == "") {
		            $("#message").html("请输入密码！");
		            return false;
		        } else {
		            return true;
		        }
		return true;
	}
	function showResponse(data) {
		if (data.success) {
			window.location.href = "${pageContext.request.contextPath }/main/index";
		} else {
			$("#message").html(data.error);
		}
	}
</script>
</html>