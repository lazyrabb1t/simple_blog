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
		<h4 class="modal-title" id="myModalLabel">类型管理</h4>
	</div>
	<form action="${pageContext.request.contextPath }/article/setting" method="post" id="settingform">
		<div class="modal-body" style="height: 300px; overflow-y: scroll">
			<div class="row">
				<div class="col-md-8">
					<input type="text" class="input01" placeholder="这里输入新的类型名称..." value="${article.tittle }" id="newtype" /> <a href="javascript:void(0)" onclick="addType();" title="添加该类型"
						style="margin-left: 10px;"> <!-- 						<span class="ti-check"></span> --> 添加该分类
					</a>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<table class="table01" style="width: 100%; margin-top: 20px;">
						<!-- 				<table class="table table-striped " style="border-bottom: 1px solid #ddd;border-top: 1px solid #ddd;margin-top: 20px;"> -->
						<thead>
							<!-- 							<th width="10%">#</th> -->
							<th width="80%" style="padding-left: 50px;">type</th>
							<th width="20%">operate</th>
						</thead>
						<tbody>
							<c:if test="${!empty list }">
								<c:forEach items="${list}" var="type" varStatus="vs">
									<tr id="tr_${type.id }">
										<!-- 										<td> -->
										<%-- 											<c:out value='${vs.index+1}' /> --%>
										<!-- 										</td> -->
										<td id="td_${type.id }" style="padding-left: 50px;">${type.type }</td>
										<td><a href="javascript:void(0)" onclick="editArticletype('${type.id }');" title="编辑" id="edit_${type.id }"> <span class="ti-write"></span>
										</a> &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)" onclick="deleteArticletype('${type.id }');" title="删除"> <span class="ti-close"></span>
										</a></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn2 btn-primary" data-dismiss="modal">完成</button>
		</div>
	</form>
</body>
<script type="text/javascript">
	$(function() {
		$("#setting-sure").click(function() {
			$.post('${pageContext.request.contextPath }/article/setting', {
				articleId : $('#articleId').val()
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
	function addType() {
		var type = $("#newtype").val();
		if ($.trim(type) == "") {
			alert("请输入...");
		} else {
			$.post('${pageContext.request.contextPath }/article/typesave', {
				newtype : type
			}, function(data) {
				alert(data.error);
				if (data.success) {
					$("#myModal").modal('hide');
					refresh();
				}
				// 				if (data.success) {
				// 					alert("配置成功！");
				// 					$("#myModal").modal('hide');
				// 				} else {
				// 					alert(data.error);
				// 				}
			});
		}
	}
	function deleteArticletype(typeid) {
		$.get('${pageContext.request.contextPath }/article/typedelete', {
			id : typeid
		}, function(data) {
			alert(data.error);
			if (data.success) {
				var tr_id = "tr_" + typeid;
				$("#"+tr_id).remove();
				refresh();
				//             $("#myModal").modal('hide');
			}
			//          if (data.success) {
			//              alert("配置成功！");
			//              $("#myModal").modal('hide');
			//          } else {
			//              alert(data.error);
			//          }
		});
	}
	function confirmEdit(typeid) {
		var input_id = "input_" + typeid;
		var newtype = $('#' + input_id).val();
		if ($.trim(newtype) == "") {
			alert("不能为空...");
		} else {
			$.post('${pageContext.request.contextPath }/article/typeedit', {
				id : typeid,
				type : newtype
			}, function(data) {
				alert(data.error);
				if (data.success) {
					//             $("#myModal").modal('hide');
					var td_id = "td_" + typeid;
					$('#' + td_id).html(newtype);
					usable_a(typeid,"auto");
					refresh();
				}
			});
		}
	}
	function cancelEdit(typeid, oldtype) {
		var td_id = "td_" + typeid;
		$('#' + td_id).html(oldtype);
		usable_a(typeid,"auto");
	}
	function editArticletype(typeid) {
		var td_id = "td_" + typeid;
		disabled_a(typeid);
		var txt = $('#' + td_id).text();
		$('#' + td_id).html(
				"<input type='text'value='" + txt + "' id='input_"+typeid+"'/>&nbsp;&nbsp;&nbsp;&nbsp;" + "<a href='javascript:void(0)' onclick='confirmEdit(&quot;" + typeid
						+ "&quot;);' title='确定修改'>确定</a>|<a href='javascript:void(0)' onclick='cancelEdit(&quot;" + typeid + "&quot;,&quot;" + txt
						+ "&quot;);' title='取消修改'>取消</a>");
	}
	function disabled_a(typeid){
		var edit_id = "edit_" + typeid;
//         $('#' + edit_id).css("pointer-events", "none");
        $('#' + edit_id).css({"pointer-events":"none","color":"#9A9A9A"});
	}
	   function usable_a(typeid){
	        var edit_id = "edit_" + typeid;
// 	        $('#' + edit_id).css("pointer-events", "auto");
	        $('#' + edit_id).css({"pointer-events":"auto","color":"#68B3C8"});
	    }
</script>
</html>