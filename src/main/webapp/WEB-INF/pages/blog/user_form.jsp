<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath }/images/carrot03.png">
<title>Go In 4</title></script>
</head>
<style type="text/css">
.thumbnail {
	border: 1px;
}

img {
	border-radius: 100%;
}
</style>
<body>
	<div class="container-fluid">
		<div class="row">
			<!-- 			<div class="col-lg-4 col-md-5"> -->
			<!-- 				<div class="card card-user"> -->
			<!-- 					<div class="image"> -->
			<!-- 						<img src="${pageContext.request.contextPath }/images/background.jpg" alt="..." /> -->
			<!-- 					</div> -->
			<!-- 					<div class="content"> -->
			<!-- 						<div class="author"> -->
			<!-- 							<img class="avatar border-white" src="${pageContext.request.contextPath }/images/2ha.jpg" alt="..." /> -->
			<!-- 							<h4 class="title"> -->
			<!-- 								lazyRabbit -->
			<!-- 							</h4> -->
			<!-- 						</div> -->
			<!-- 						<p class="description text-center"> -->
			<!-- 							halaala12312312322222222123123 -->
			<!-- 						</p> -->
			<!-- 					</div> -->
			<!-- 					<hr> -->
			<!-- 					<div class="text-center"> -->
			<!-- 						<div class="row"> -->
			<!-- 							<div class="col-md-3 col-md-offset-1"> -->
			<!-- 								<h5> -->
			<!-- 									12<br /> -->
			<!-- 									<small>Blogs</small> -->
			<!-- 								</h5> -->
			<!-- 							</div> -->
			<!-- 							<div class="col-md-4"> -->
			<!-- 								<h5> -->
			<!-- 									256<br /> -->
			<!-- 									<small>Hits</small> -->
			<!-- 								</h5> -->
			<!-- 							</div> -->
			<!-- 							<div class="col-md-3"> -->
			<!-- 								<h5> -->
			<!-- 									1024<br /> -->
			<!-- 									<small>Liked</small> -->
			<!-- 								</h5> -->
			<!-- 							</div> -->
			<!-- 						</div> -->
			<!-- 					</div> -->
			<!-- 				</div> -->
			<!-- 			</div> -->
			<!-- 			<div class="col-lg-8 col-md-7"> -->
			<div class="col-md-12">
				<div class="card">
					<div class="header">
						<h4 class="title">Edit Profile</h4>
						<hr>
					</div>
					<div class="content">
						<form action="${pageContext.request.contextPath }/user/save" method="post" id="userform">
							<div class="row">
								<div class="col-md-2">
									<div class="form-group" style="width: 90%;">
										<!-- 										<label>Profile Picture</label> -->
										<div class="fileinput fileinput-new" data-provides="fileinput" id="exampleInputUpload">
											<div class="fileinput-new thumbnail" style="width: 100%; height: auto; float: left;">
												<c:if test="${not empty attachment}">
													<img id='picImg' style="" src="${pageContext.request.contextPath }${attachment.savepath }" alt="" />
												</c:if>
												<c:if test="${empty attachment}">
													<img id='picImg' src="${pageContext.request.contextPath }/images/2ha.jpg" alt="" />
												</c:if>
											</div>
											<div class="fileinput-preview fileinput-exists thumbnail" style="width: 100%; float: left;"></div>
											<div style="text-align: center;">
												<span class="btn2 btn-primary btn-file" style=""> <span class="fileinput-new">选择图片</span> <span class="fileinput-exists">换一张</span> <input type="file"
													name="pic1" id="picID" accept="image/gif,image/jpg,image/jpeg,image/x-png" />
												</span> <a href="javascript:;" class="btn2 btn-warning fileinput-exists" data-dismiss="fileinput">移除</a>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-10">
									<div class="row">
										<div class="col-md-4">
											<div class="form-group">
												<label>Profile Name</label> <input type="text" class="form-control border-input" placeholder="Username" value="${user.username }" name="username">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-10">
											<div class="form-group">
												<label>LOL</label>
												<textarea rows="6" class="form-control border-input" placeholder="Here can be your description" name="lol">${user.lol }</textarea>
											</div>
										</div>
									</div>
								</div>

							</div>
							<div class="text-center">
								<button type="submit" class="btn btn-info btn-fill btn-wd">更新</button>
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
		//ajaxform
		var options = {
			beforeSubmit : showRequest, // pre-submit callback 
			success : showResponse, // post-submit callback 
			dataType : "json",
			resetForm : false
		};
		$('#userform').ajaxForm(options);
	});
	function showRequest() {
		return true;
	}
	function showResponse(data) {
		alert(data.error);
	}
</script>
</html>