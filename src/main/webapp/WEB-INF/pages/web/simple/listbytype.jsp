<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96" href="../images/carrot03.png">
<title>lazyRabbit的博客</title>
</head>
<body>

	<!-- Post -->
	<article class="post" style="width: 80%;margin: 0 auto;">
	<div style="width: 100%; height: 38px;">
		<div style="float: right; height: 38px; line-height: 38px">
			<a href="${pageContext.request.contextPath }/simple" class="button icon fa-home">主页</a>
		</div>
		<div style="float: left; height: 38px; line-height: 38px">
			<h2>${type }</h2>
		</div>
	</div>

	<hr />
	<c:if test="${empty pageInfo.list}">
		<h4 style="margin: 0px;">Sorry i'm lazy...</h4>
		<hr />
	</c:if> <c:forEach items="${pageInfo.list}" var="article" varStatus="vs">
		<section>
		<h3 style="margin: 0px;">
			<a href="javascript:void(0)" onclick="selectMenu('/web/${article.articleId }/simpledetail');">${article.tittle }</a>
		</h3>
		<div class="m_meta" style="width: 100%; height: 4em;">
			<div style="float: left; height: 4em; line-height: 4em">${article.stringTime }</div>
			<div>
				<a href="javascript:void(0)" class="author"> <span class="name">${article.author }</span>
				</a>
			</div>

		</div>
		<div style="font-size: 15px;">${article.content }</div>

		</section>
		<footer>
		<ul class="actions" style="margin-bottom: 0px;">
		</ul>
		<ul class="stats" style="margin-bottom: 0px;">
			<li><a href="javascript:void(0)" onclick="selectMenu('/web/simplelistbytype?typeid=${article.articleType.id }&type=${article.articleType.type }');">${article.articleType.type
					}</a></li>
			<li><a href="javascript:void(0)" class="icon fa-eye">${article.hits }</a></li>
			<li><a href="javascript:void(0)" class="icon fa-heart">${article.liked }</a></li>

		</ul>
		</footer>
		<hr style="margin: 10px 0 20px 0">
	</c:forEach> <!-- Pagination -->
	<ul class="actions pagination">
		<li><a href="javascript:void(0)" onclick="selectMenu('/web/simplelistbytype?typeid=${typeid}&type=${type}&cp=${pageInfo.pageNum-1}');"
			class="<c:if test="${pageInfo.isFirstPage }">disabled </c:if> button big previous">上一页</a></li>
		<li><a href="javascript:void(0)" onclick="selectMenu('/web/simplelistbytype?typeid=${typeid}&type=${type}&cp=${pageInfo.pageNum+1}');"
			class="<c:if test="${pageInfo.isLastPage}">disabled </c:if>button big next">下一页</a></li>
	</ul>

	</article>
</body>
</html>