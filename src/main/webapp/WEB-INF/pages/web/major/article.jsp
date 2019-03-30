<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="inc/meta.jsp"%>
<title>${article.tittle}&nbsp;-&nbsp;lazyRabbit的博客</title>
<%@ include file="inc/css.jsp"%>
<style type="text/css">
.syntax-container {
	font-size: 13px;
	margin-bottom: 20px;
}

p {
	margin-bottom: 20px;
}

a {
	color: #4298BA;
}
</style>
</head>
<body>
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<%@ include file="inc/header.jsp"%>
		<!-- Main -->
		<div id="main">
			<article class="post"> <header>
			<div class="title">
				<h2>
					<a href="javascript:void(0)">${article.tittle}</a>
				</h2>
			</div>
			<div class="meta">
				<time class="published"> <fmt:formatDate pattern="MMM d, yyyy HH:mm:ss" value="${article.updateTime }" /></time>
				<a href="javascript:void(0)" class="author">
					<span class="name">${article.author}</span>
					<c:if test="${empty profilepicture}">
						<img src="${pageContext.request.contextPath }/images/defaultprofilepicture.jpg" alt="hello" />
					</c:if>
					<c:if test="${not empty profilepicture}">
						<img src="${pageContext.request.contextPath }${profilepicture }" alt="hello" />
					</c:if>
				</a>
			</div>
			</header> ${article.content} <footer>
			<ul class="actions">
				<li>
					<a href="${pageContext.request.contextPath }/" class="button big">返回首页</a>
				</li>
			</ul>
			<ul class="stats">
				<li>
					<a href="/tags/${article.articleType.id }"">${article.articleType.type}</a>
				</li>
				<li>
					<a href="javascript:void(0)" class="icon fa-eye">${article.hits }</a>
				</li>
				<li>
					<a href="javascript:void(0)" class="icon" onclick="liked('${article.articleId }');" id="likedfunction">
						<i class="fa fa-heart" style="margin-right: 0.75em; color: rgba(160, 160, 160, 0.3);" id="likedcss"></i>
						<i id="likednumber">${article.liked }</i>
					</a>
				</li>
			</ul>
			</footer> </article>
		</div>
		<!-- Sidebar -->
		<%@ include file="inc/sidebar.jsp"%>
		<!-- 返回顶部 -->
		<a class="to-top fa fa-chevron-up" tittle="返回顶部"></a>
</body>
<%@ include file="inc/js.jsp"%>
<script type="text/javascript">
	$(function() {
		$('.to-top').toTop({
			"right" : 1,
			"bottom" : 160
		});
		$.syntax({
			brush : 'ruby',
			theme : 'grey',
			layout : 'fixed',
			replace : true
		});
	});
	function liked(articleId) {
		$.post('${pageContext.request.contextPath }/web/liked', {
			id : articleId
		}, function(data) {
			//          alert(data.error);
			$("#likednumber").html("${article.liked+1 }");
			$("#likedcss").css("color", "#2ebaae");
			$("#likedfunction").attr("onclick", "regret('${article.articleId }');");
		});
	}
	function regret(articleId) {
		$.post('${pageContext.request.contextPath }/web/regret', {
			id : articleId
		}, function(data) {
			//          alert(data.error);
			$("#likednumber").html("${article.liked }");
			//          $("#likedcss").removeClass("halala");
			$("#likedcss").css("color", "rgba(160, 160, 160, 0.3)");
			$("#likedfunction").attr("onclick", "liked('${article.articleId }');");
		});
	}
</script>
</html>