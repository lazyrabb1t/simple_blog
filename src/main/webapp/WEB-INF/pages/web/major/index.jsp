<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="inc/meta.jsp"%>
<title>lazyRabbit的博客</title>
<%@ include file="inc/css.jsp"%>
</head>
<body>
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<%@ include file="inc/header.jsp"%>
		<!-- Main -->
		<div id="main">
			<c:forEach items="${pageInfo.list}" var="article" varStatus="vs">
				<!-- Post -->
				<article class="post"> <header>
				<div class="title">
					<h2>
						<a href="/detail/${article.articleId }">${article.tittle }</a>
					</h2>
					<!--			<p>Lorem ipsum dolor amet nullam consequat etiam feugiat</p> -->
				</div>
				<div class="meta">
					<time class="published"> <fmt:formatDate pattern="MMM d, yyyy HH:mm:ss" value="${article.updateTime }" /></time>
					<a href="javascript:void(0)" class="author">
						<span class="name">${article.author }</span>
						<c:if test="${empty profilepicture}">
							<img src="${pageContext.request.contextPath }/images/samoye.jpg" alt="hello" />
						</c:if>
						<c:if test="${not empty profilepicture}">
							<img src="${pageContext.request.contextPath }${profilepicture }" alt="hello" />
						</c:if>
					</a>
				</div>
				</header> <a href="/detail/${article.articleId }" style="border-bottom: 0px;">
					<p style="margin: 0 0 1em 0">${article.content }</p>
				</a> <footer>
				<ul class="actions" style="margin-bottom: 6px;">
				</ul>
				<ul class="stats" style="margin-bottom: 6px;">
					<li>
						<a href="/tags/${article.articleType.id }">${article.articleType.type }</a>
					</li>
					<li>
						<a href="javascript:void(0)" class="icon fa-eye">${article.hits }</a>
					</li>
					<li>
						<a href="javascript:void(0)" class="icon fa-heart">${article.liked }</a>
					</li>

				</ul>
				</footer> </article>
			</c:forEach>
			<c:if test="${not empty pageInfo.list}">
				<!-- Pagination -->
				<ul class="actions pagination">
					<li>
						<a href="?cp=${pageInfo.pageNum-1}" class="<c:if test="${pageInfo.isFirstPage }">disabled </c:if> button big previous">上一页</a>
					</li>
					<li>
						<a href="?cp=${pageInfo.pageNum+1}" class="<c:if test="${pageInfo.isLastPage}">disabled </c:if>button big next">下一页</a>
					</li>
				</ul>
			</c:if>
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
	});
</script>
</html>