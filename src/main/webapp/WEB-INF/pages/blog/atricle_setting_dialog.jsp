<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath }/images/carrot03.png">
<title>Go In 4</title>
</head>
<body>
	<!-- Modal -->
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		<h4 class="modal-title" id="myModalLabel">配置</h4>
	</div>
	<form action="${pageContext.request.contextPath }/article/setting" method="post" id="settingform">
		<div class="modal-body">

			<input type="hidden" id="articleId" name="articleId" value="${article.articleId }">
			<ul class='tg-list'>
				<li class='tg-list-item'>是否置顶：</li>
				<li class='tg-list-item'><input class='tgl tgl-ios' id='cb1' type='checkbox'> <label class='tgl-btn' for='cb1'></label></li>
				<li class='tg-list-item'><span id="message1" class="prompt_message"></span></li>
			</ul>
			<ul class='tg-list'>
				<li class='tg-list-item'>是否推荐：</li>
				<li class='tg-list-item'><input class='tgl tgl-ios' id='cb2' type='checkbox'> <label class='tgl-btn' for='cb2'></label></li>
				<li class='tg-list-item'><span id="message2" class="prompt_message"></span></li>
			</ul>
			<ul class='tg-list'>
				<li class='tg-list-item'>是否发布：</li>
				<li class='tg-list-item'><input class='tgl tgl-ios' id='cb3' type='checkbox'> <label class='tgl-btn' for='cb3'></label></li>
				<li class='tg-list-item'><span id="message3" class="prompt_message"></span></li>
			</ul>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn2 btn-default" data-dismiss="modal">取消</button>
			<button type="button" class="btn2 btn-primary" id="setting-sure">确定</button>
		</div>
	</form>
</body>
<script type="text/javascript">
	$(function() {
		var ispublish = '${article.ispublish }';
		var iselite = '${article.iselite }';
		var ontop = '${article.ontop }';
		if (ispublish == '1') {
			$("#cb3").attr("checked", "checked");
		}
		if (iselite == '1') {
			$("#cb2").attr("checked", "checked");
		}
		if (ontop == '1') {
			$("#cb1").attr("checked", "checked");
		}
		$("#cb1").change(function() {
			if ($("#cb1").prop("checked")) {
				$("#message1").html("你将置顶这篇博客");
				ontop = '1';
			} else {
				$("#message1").html("");
				ontop = '0';
			}
			console.log(ontop);
		});
		$("#cb2").change(function() {
			if ($("#cb2").prop("checked")) {
				$("#message2").html("你将推荐这篇博客");
				iselite = 1;
			} else {
				$("#message2").html("");
				iselite = 0;
			}
		});
		$("#cb3").change(function() {
			if ($("#cb3").prop("checked")) {
				$("#message3").html("你将发布这篇博客");
				ispublish = 1;
			} else {
				$("#message3").html("");
				ispublish = 0;
			}
		});
		$("#setting-sure").click(function() {
			$.post('${pageContext.request.contextPath }/article/setting', {
				articleId : $('#articleId').val(),
				ispublish : ispublish,
				iselite : iselite,
				ontop : ontop
			}, function(data) {
				if (data.success) {
				    alert("配置成功！");
				    $("#myModal").modal('hide');
				} else {
					alert(data.error);
				}
			});
		});
	});
</script>
</html>