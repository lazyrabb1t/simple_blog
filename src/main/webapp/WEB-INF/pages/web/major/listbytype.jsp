<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="inc/meta.jsp"%>
<title>${tag.type }&nbsp;-&nbsp;lazyRabbit的博客</title>
<%@ include file="inc/css.jsp"%>
</head>
<body>
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<%@ include file="inc/header.jsp"%>
		<!-- Main -->
		<div id="main">
			<article class="post">
			<div style="width: 100%; height: 38px;">
				<div style="float: right; height: 38px; line-height: 38px">
					<a href="${pageContext.request.contextPath }/" class="button icon fa-home">主页</a>
				</div>
				<div style="float: left; height: 38px; line-height: 38px">
					<h2>${tag.type }</h2>
				</div>
			</div>
			<hr />
			<c:if test="${empty pageInfo.list}">
				<h4 style="margin: 0px;">没有相关内容...</h4>
				<hr />
			</c:if> <c:forEach items="${pageInfo.list}" var="article" varStatus="vs">
				<section>
				<h3 style="margin: 0px;">
					<a href="/detail/${article.articleId }">${article.tittle }</a>
				</h3>
				<div class="m_meta" style="width: 100%; height: 4em;">
					<div style="float: left; height: 4em; line-height: 4em;">
						<fmt:formatDate pattern="MMM d, yyyy HH:mm:ss" value="${article.updateTime }" />
					</div>
					<div>
						<a href="javascript:void(0)" class="author">
							<span class="name">${article.author }</span>
							<c:if test="${empty profilepicture}">
								<img src="${pageContext.request.contextPath }/images/defaultprofilepicture.jpg" alt="hello" />
							</c:if>
							<c:if test="${not empty profilepicture}">
								<img src="${pageContext.request.contextPath }${profilepicture }" alt="hello" />
							</c:if>
						</a>
					</div>
				</div>
				<div style="font-size: 15px; margin-left: 0px;">
					<a href="/detail/${article.articleId }" style="border-bottom: 0px; color: #646464;">
						<p style="margin: 0 0 1em 0">${article.content }</p>
					</a>
				</div>
				</section>
				<footer>
				<ul class="actions" style="margin-bottom: 0px;">
				</ul>
				<ul class="stats" style="margin-bottom: 0px;">
					<li>
						<a href="/tags/${article.articleType.id }">${article.articleType.type}</a>
					</li>
					<li>
						<a href="javascript:void(0)" class="icon fa-eye">${article.hits }</a>
					</li>
					<li>
						<a href="javascript:void(0)" class="icon fa-heart">${article.liked }</a>
					</li>
				</ul>
				</footer>
				<hr style="margin: 10px 0 20px 0">
			</c:forEach> </article>

			<!-- Pagination -->
			<c:if test="${not empty pageInfo.list}">
				<ul class="actions pagination">
					<li>
						<a href="/tags/${tag.id}?cp=${pageInfo.pageNum-1}" class="<c:if test="${pageInfo.isFirstPage }">disabled </c:if> button big previous">上一页</a>
					</li>
					<li>
						<a href="/tags/${tag.id}?cp=${pageInfo.pageNum+1}" class="<c:if test="${pageInfo.isLastPage}">disabled </c:if>button big next">下一页</a>
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