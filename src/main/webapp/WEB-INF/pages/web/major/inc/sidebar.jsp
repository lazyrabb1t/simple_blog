<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Sidebar -->
<section id="sidebar">
	<section id="intro">
		<a href="${pageContext.request.contextPath }/" class="logo"> <img src="${pageContext.request.contextPath }/images/logo.jpg" />
		</a>
		<header> ${lol } </header>
	</section>
	<section>
		<div class="mini-posts">
			<!-- Mini Post -->
			<c:forEach items="${iseliteList}" var="article" varStatus="vs">
				<article class="mini-post">
					<header>
						<h3>
							<a href="/detail/${article.articleId }">${article.tittle }</a>
						</h3>
						<time class="published">
							<fmt:formatDate pattern="MMM d, yyyy h:mm:ss" value="${article.updateTime }" />
						</time>
						<a href="javascript:void(0)" class="author"> <c:if test="${empty profilepicture}">
								<img src="${pageContext.request.contextPath }/images/defaultprofilepicture.jpg" alt="hello" />
							</c:if> <c:if test="${not empty profilepicture}">
								<img src="${pageContext.request.contextPath }${profilepicture }" alt="hello" />
							</c:if>
						</a>
					</header>
					<c:if test="${not empty article.attachment}">
						<a href="/detail/${article.articleId }" class="image"> <img src="${pageContext.request.contextPath }${article.attachment.savepath }" alt="" />
						</a>
					</c:if>
				</article>
			</c:forEach>
		</div>
	</section>
	<section class="blurb">
		<h3>Tags</h3>
		<ul class="actions">
			<c:forEach items="${typeList}" var="type" varStatus="vs">
				<li><a href="/tags/${type.id}" class="button small" style="margin-top: 10px;">${type.type}</a></li>
			</c:forEach>
			<li><a href="/tags/0" class="button small" style="margin-top: 10px;">我全都要</a></li>
		</ul>
	</section>
	<!-- Footer -->
	<section id="footer" class="blurb">
		<h3>Links</h3>
		<p>
			<a href="http://www.aizhangyang.com/" target="_blank" style="border-bottom: 0px;"><i class="icon fa-chevron-right" style="margin-right: 20px;"></i>这里是聪MM的博客</a>
		</p>
	</section>
</section>
</div>