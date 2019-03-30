<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath }/images/carrot03.png">
<title>Go In 4</title>
</head>
<body>
	<!-- Modal -->
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		<h4 class="modal-title" id="myModalLabel">修改密码</h4>
	</div>
	<form action="${pageContext.request.contextPath }/article/setting" method="post" id="settingform">
		<div class="modal-body">

			<div class="content" style="margin-top: 20px;">
				<form id="loginform" action="${pageContext.request.contextPath }/login/check">
					<div class="row">
						<div class="col-md-12">
							<div class="form-group center-block" style="width: 60%">
								<input type="password" class="form-control border-input" placeholder="请输入原密码" name="accountname" id="oldpassword">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="form-group center-block" style="width: 60%">
								<input type="password" class="form-control border-input" placeholder="请输入新密码" name="password" id="newpassword1">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="form-group center-block" style="width: 60%">
								<input type="password" class="form-control border-input" placeholder="请再输入一次新密码" name="password" id="newpassword2">
							</div>
						</div>
					</div>
					<div style="width: 60%; margin-top: 0px; text-align: left; color: red; height: 20px;">
						<span id="message"></span>
					</div>
				</form>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn2 btn-default" data-dismiss="modal">取消</button>
			<button type="button" class="btn2 btn-primary" id="setting-sure">确定</button>
		</div>
	</form>
</body>
<script type="text/javascript">
	$(function() {
		$("#setting-sure").click(function() {
			var message = $("#message");
			var oldpassword = $("#oldpassword").val();
			var newpassword1 = $("#newpassword1").val();
			var newpassword2 = $("#newpassword2").val();
			if (oldpassword == "" || newpassword1 == "" || newpassword2 == "") {
				message.html("请输入...");
			}else if(newpassword1!=newpassword2){
				message.html("两次密码输入不一致...");
			}else{
				$.post('${pageContext.request.contextPath }/user/changepwd', {
					oldpassword : oldpassword,
					newpassword : newpassword1,
				}, function(data) {
					message.html(data.error);
					if (data.success) {
						$("#myModal").modal('hide');
						alert("修改成功,请重新登录...");
						window.location.href="${pageContext.request.contextPath }/login/out";
					}
				});
			}
		});
	});
</script>
</html>