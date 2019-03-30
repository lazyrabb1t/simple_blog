<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96" href="../images/carrot03.png">
<title>lazyRabbit的博客</title>
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


	<!-- Post -->
	<article class="post" style="width: 80%;margin: 0 auto;"> <header
		style="margin-bottom: 2em;">
	<div class="title" style="padding: 3em 3em 1.5em;">
		<h2 style="margin: 0">
			<a style="cursor: pointer;">${article.tittle}</a>
		</h2>
		<div class="m_meta" style="width: 100%; height: 38px;">
			<div style="float: left; height: 38px; line-height: 39px">
				<a href="javascript:void(0)" class="author" style="color: #3c3b3b;">${article.author }
				</a>
			</div>
			<div
				style="float: left; height: 38px; line-height: 38px; margin-left: 20px;">
				<fmt:formatDate pattern="MMM d, yyyy HH:mm:ss"
					value="${article.updateTime }" />
			</div>


		</div>
	</div>
	<!-- 	<div class="meta"> --> <%-- 		<time class="published"> <fmt:formatDate pattern="MMM d, yyyy h:mm:ss" value="${article.updateTime }" /></time> --%>
	<!-- 		<a style="cursor: pointer;" class="author"> --> <%-- 			<span class="name">${article.author}</span> --%>
	<!-- 		</a> --> <!-- 	</div> --> </header> ${article.content} <footer>
	<ul class="actions">
		<li><a href="javascript:void(0)" onclick="back();"
			class="button big">返回</a></li>
	</ul>
	<ul class="stats">
		<li><a href="javascript:void(0)"
			onclick="selectMenu('/web/simplelistbytype?typeid=${article.articleType.id }&type=${article.articleType.type }');">${article.articleType.type
				}</a></li>
		<li><a href="javascript:void(0)" class="icon fa-eye">${article.hits }</a></li>
		<li><a href="javascript:void(0)" class="icon"
			onclick="liked('${article.articleId }');" id="likedfunction"> <i
				class="fa fa-heart"
				style="margin-right: 0.75em; color: rgba(160, 160, 160, 0.3);"
				id="likedcss"></i> <i id="likednumber">${article.liked }</i>
		</a></li>
	</ul>
	</footer> </article>
</body>
<script type="text/javascript">
	$(function() {
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
			$("#likednumber").html("${article.liked+1 }");
			$("#likedcss").css("color", "#2ebaae");
			$("#likedfunction").attr("onclick",
					"regret('${article.articleId }');");
		});
	}
	function regret(articleId) {
		$.post('${pageContext.request.contextPath }/web/regret', {
			id : articleId
		}, function(data) {
			$("#likednumber").html("${article.liked }");
			//          $("#likedcss").removeClass("halala");
			$("#likedcss").css("color", "rgba(160, 160, 160, 0.3)");
			$("#likedfunction").attr("onclick",
					"liked('${article.articleId }');");
		});
	}
</script>
</html>