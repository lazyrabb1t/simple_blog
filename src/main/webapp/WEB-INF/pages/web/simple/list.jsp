<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96" href="../images/carrot03.png">
<title>lazyRabbit的博客</title>
<style type="text/css">
#intro .logo:before {
	background-image:
		url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100px' height='100px' viewBox='0 0 100 100' preserveAspectRatio='none' zoomAndPan='disable'%3E%3Cpolygon points='0,0 100,0 100,25 50,0 0,25' style='fill:#fff' /%3E%3Cpolygon points='0,100 100,100 100,75 50,100 0,75' style='fill:#fff' /%3E%3C/svg%3E");
}
.getmore {
	margin: 0 auto;
	width: 130px;
	height: 40px;
	line-height: 40px;
	height: 40px;
}

.getmore li {
	list-style: none;
	padding: 0;
	margin: 0 3px;
	float: left;
}
</style>
</head>
<body>
	<!-- Post -->
	<article class="post" style="width: 80%;margin: 0 auto;">
	<div id="intro">
		<a href="${pageContext.request.contextPath }/simple" class="logo" style="background-color: #fff;"> <img src="../images/logo.jpg" alt="" />
		</a>
		<header> ${lol } </header>
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
		<div class="m_meta" style="width: 100%; height: 38px;">
			<div style="float: left; height: 38px; line-height: 38px">${article.stringTime }</div>
			<div>
				<a href="javascript:void(0)" class="author"> <span class="name">${article.author }</span>
				</a>
			</div>

		</div>
		<div style="font-size: 15px;">
			<a href="javascript:void(0)" onclick="selectMenu('/web/${article.articleId }/simpledetail');" style="border-bottom: 0px;">${article.content }</a>
		</div>
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
		<hr style="margin: 10px 0 20px 0;">
	</c:forEach> <section style="text-align: center;height:4.8125em" id="more"> <a href="javascript:void(0)" class="button" style="width: 200px;" onclick="moreArticles('2');">浏览更多</a> </section>
</body>
<script type="text/javascript">
function moreArticles(cp) {
	$("#more").html('<img src="../images/svg-loaders/puff.svg" style="height: 40px;">');
	$.post('${pageContext.request.contextPath }/web/simplemore',{
		cp : cp
	},function(data) {
		var html = '';
		if(data.length>0){
	    var next = Number(cp)+Number('1');
			$.each(data, function(i, article) {
				html += '<section>';
				html += '<h3 style="margin: 0px;">';
				html += '<a href="javascript:void(0)" onclick="selectMenu(&apos;/web/'+article.articleId+'/simpledetail&apos;);">'+article.tittle+'</a>';
				html += '</h3>';
				html += '<div class="m_meta" style="width: 100%; height: 38px;">';
				html += '<div style="float: left; height: 38px; line-height: 38px">';
				html += article.stringTime;
				html += '</div>';
				html += '<div>';
				html += '<a href="javascript:void(0)" class="author"><span class="name">'+article.author +'</span></a>';
				html += '</div>';
				html += '</div>';
				html += '<div style="font-size: 15px;">';
				html += '<a href="javascript:void(0)" onclick="selectMenu(&apos;/web/'+article.articleId +'/simpledetail&apos;);" style="border-bottom: 0px;">'+article.content +'</a>';
				html += '</div>';
				html += '</section>';
				html += '<footer>';
				html += '<ul class="actions" style="margin-bottom: 0px;">';
				html += '</ul>';
				html += '<ul class="stats" style="margin-bottom: 0px;">';
				html += '<li>';
				html += '<a href="javascript:void(0)" onclick="selectMenu(&apos;/web/simplelistbytype?typeid='+article.articleType.id +'&type='+article.articleType.type +'&apos;);">'+article.articleType.type+'</a>';
				html += '</li>';
				html += '<li>';
				html += '<a href="javascript:void(0)" class="icon fa-eye">'+article.hits +'</a>';
				html += '</li>';
				html += '<li>';
				html += '<a href="javascript:void(0)" class="icon fa-heart">'+article.liked +'</a>';
				html += '</li>';
				html += '</ul>';
				html += '</footer>';
				html += '<hr style="margin: 10px 0 20px 0;">';
			});
		html+='<section style="text-align: center;height:4.8125em" id="more">';
		html+='<a href="javascript:void(0)" class="button" style="width: 200px;" onclick="moreArticles(&apos;'+next+'&apos;);">浏览更多</a>';
		html+='</section>';
		}else{
		    html+='<section style="text-align: center;height:4.8125em" id="more">';
		    html+='<a href="javascript:void(0)" class="button disabled" style="width: 200px;" onclick="moreArticles(&apos;'+next+'&apos;);">已经没有更多内容了呦</a>';
		    html+='</section>';
		}
	$("#more").remove();
	$(".post").append(html);
	});
}
</script>
</html>