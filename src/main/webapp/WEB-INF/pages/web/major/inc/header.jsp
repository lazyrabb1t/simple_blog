<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Header -->
<header id="header">
	<h1>
		<a href="${pageContext.request.contextPath }/">goInFor</a>
	</h1>
	<nav class="links" style="border: 0px;">
		<ul>
			<li><a href="${pageContext.request.contextPath }/simple">Simple</a></li>
			<li><a href="${pageContext.request.contextPath }/">Major</a></li>
		</ul>
	</nav>
	<nav class="main">
		<ul>
			<li class="search"><a class="fa-search" href="#search">Search</a>
				<div id="search">
					<input type="text" name="keyword" id="keyword" placeholder="Search" style="margin-top: 10px; height: 35px;" />
				</div></li>
		</ul>
	</nav>
</header>