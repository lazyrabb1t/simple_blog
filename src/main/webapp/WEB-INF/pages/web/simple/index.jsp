<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96" href="../images/carrot03.png">
<title>lazyRabbit的博客</title>
<%@ include file="inc/css.jsp"%>
<style type="text/css">
.to-top {
	display: none;
	padding: 8px 15px;
	background-color: #fff;
}
</style>
</head>
<body>
	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Header -->
		<header id="header">
		<h1>
			<a href="${pageContext.request.contextPath }/simple">goInFor</a>
		</h1>
		<nav class="links" style="border:0px;">
		<ul>
			<li><a href="../simple">Simple</a></li>
			<li><a href="../">major</a></li>
		</ul>
		</nav> </header>
		<!-- Main -->
		<div id="main"></div>
		<a class="to-top fa fa-chevron-up" tittle="返回顶部"></a>
	</div>
</body>
<%@ include file="inc/js.jsp"%>
<script type="text/javascript">
	$(function() {
		selectMenu('/web/simplelist');
		$('.to-top').toTop({
			//'position': false
			"right" : 110,
			"bottom" : 160
		});
	});
	var lastPath = '/web/simplelist';
	var currentPath = '/web/simplelist';
	function selectMenu(path) {
		$('#main')
				.html(
						'<ul class="loading"><li id = "loadd"><img src="../images/svg-loaders/bars.svg" width="80" alt=""></li></ul>');
		$('#main').load('${pageContext.request.contextPath }' + path);
		lastPath = currentPath;
		currentPath = path;
		window.scrollTo(0, 0);
	}
	function back() {
		selectMenu(lastPath);
	}
</script>
</html>