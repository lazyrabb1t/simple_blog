<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath }/images/carrot03.png">
<title>登录&nbsp;-&nbsp;Go In 4</title>
<link href="${pageContext.request.contextPath }/assets/bootstrap-blog/css/paper-dashboard.css" rel="stylesheet" />
<link href="https://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery.form/4.2.2/jquery.form.js"></script>
</head>
<style type="text/css">
.main2 {
	text-align: center; /*让div内部文字居中*/
	border-radius: 20px;
	width: 399px;
	height: 266px;
	margin: auto;
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
}
</style>
<body>
	<div class="content main2">
		<div class="row">
			<div style="width: 100%;">
				<div class="card">
					<div class="header">
						<h4 class="title">LOGIN</h4>
					</div>
					<div class="content">
						<form id="loginform" action="${pageContext.request.contextPath }/login/check">
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<input type="text" class="form-control border-input" placeholder="用户名" name="accountname" id="accountname">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<input type="password" class="form-control border-input" placeholder="密码" name="password" id="password">
									</div>
								</div>
							</div>
							<div style="margin-top: 0px; text-align: left; color: red; height: 20px;">
								<span id="message"></span>
							</div>
							<div class="text-center">
								<button type="submit" class="btn btn-info btn-fill btn-wd">登录</button>
							</div>
							<div class="clearfix"></div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
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