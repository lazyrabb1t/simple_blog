<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96"
	href="${pageContext.request.contextPath }/images/carrot03.png">
<title>Go In 4</title>
<%@ include file="inc/css.jsp"%>
<style type="text/css">
.halala {
	font-family: Raleway, Helvetica, sans-serif;
	letter-spacing: 0.45em;
}

#J_dotLine {
	display: block;
	margin: 0 auto;
}
</style>
</head>
<body>
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document" style="height: 300px;">
			<div class="modal-content"></div>
		</div>
	</div>
	<div class="wrapper">
		<div class="sidebar" data-background-color="white"
			data-active-color="danger">

			<!--
        Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
        Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
    -->

			<div class="sidebar-wrapper">
				<div class="logo">
					<a href="#" class="halala simple-text"> GOINFOR </a>
				</div>
				<ul class="nav">
					<li><a href="javascript:void(0)"
						onclick="selectMenu('/main/dashboard',this);"> <i
							class="ti-dashboard"></i>
							<p>Dashboard</p>
					</a></li>
					<li><a href="javascript:void(0)"
						onclick="selectMenu('/user/form',this);"> <i class="ti-user"></i>
							<p>User Profile</p>
					</a></li>
					<li><a href="javascript:void(0)"
						onclick="selectMenu('/article/form',this);"> <i
							class="ti-pencil"></i>
							<p>new article</p>
					</a></li>
					<li><a href="javascript:void(0)"
						onclick="selectMenu('/article/list',this);"> <i
							class="ti-view-list-alt"></i>
							<p>Article List</p>
					</a></li>

				</ul>
			</div>
		</div>

		<div class="main-panel">
			<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="collapse navbar-collapse">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"> <!-- 								<i class="ti-user"></i> -->
								<p>${currentuser }</p> <b class="caret"></b>
						</a>
							<ul class="dropdown-menu">
								<li><a href="javascript:void(0);"
									onclick="changepwdModel();">修改密码</a></li>
								<li><a href="${pageContext.request.contextPath }/logout">退出</a></li>
							</ul></li>
					</ul>

				</div>
			</div>
			</nav>


			<div class="content" id="content" style="">
			<%@ include file="inc/canvas.jsp"%>
			</div>
		</div>
	</div>
</body>
<%@ include file="inc/js.jsp"%>
<script type="text/javascript">
	var currentPath = '/main/index';
	var loadinghtml = '<ul class="loading" style="margin:100px auto;width:200px;">'
			+ '<li id = "loadd"><img src="../images/svg-loaders/tail-spin.svg" width="80" alt=""></li></ul>';
	function selectMenu(path, obj) {
		$('#content').html(loadinghtml);
		$('#content').load('${pageContext.request.contextPath }' + path,
				function() {
					if (typeof (obj) != "undefined") {
						$("li[class='active']").removeClass();
						$(obj).parent().addClass("active");
					}
				});
		currentPath = path;
	}
	function refresh() {
		selectMenu(currentPath);
	}
	function deleteArticleById(articleId) {
		if (confirm("确认要删除这篇博客吗？")) {
			$.get('${pageContext.request.contextPath }/article/delete', {
				id : articleId
			}, function(data) {
				alert(data.error);
				refresh();
			});
		}
	}
	function changepwdModel() {
		$('#myModal').modal({
			remote : '${pageContext.request.contextPath }/user/changepwdform'
		});
	}
	$("#myModal").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
</script>
</html>