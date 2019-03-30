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
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="content">
						<label class="radio-inline"> <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1" checked="checked"> 发布
						</label> <label class="radio-inline"> <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option2"> 草稿
						</label> <label class="radio-inline"> <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option3"> 置顶
						</label> <label class="radio-inline"> <input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option4"> 推荐
						</label> <label class="radio-inline"> <input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option5"> 全部
						</label>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<!-- 					<div class="header"> -->
					<!-- 					<div style="float: left;"> -->
					<!-- 						<h4 class="title">Article List</h4> -->
					<!-- 						</div> -->
					<!-- 					</div> -->
					<div class="content table-responsive table-full-width">
						<table class="table table-striped">
							<thead>
								<th>#</th>
								<th>tittle</th>
								<th>author</th>
								<th>hits</th>
								<th>updateTime</th>
								<th>operate</th>
							</thead>
							<tbody>
								<c:if test="${!empty pageInfo.list }">
									<c:forEach items="${pageInfo.list}" var="article" varStatus="vs">
										<tr>
											<td><c:out value='${vs.index+1}' /></td>
											<td>${article.tittle }</td>
											<td>${article.author }</td>
											<td>${article.hits }</td>
											<td><fmt:formatDate value="${article.updateTime }" pattern="yyyy/MM/dd  HH:mm:ss" /></td>
											<td><a href="javascript:void(0)" onclick="selectMenu('/article/form?id=${article.articleId }');" title="编辑"> <span class="ti-pencil-alt"></span>
											</a> &nbsp;&nbsp; <a href="javascript:void(0)" onclick="settingModel('${article.articleId }');"> <span class="ti-settings"></span>
											</a> &nbsp;&nbsp; <a href="javascript:void(0)" onclick="deleteArticleById('${article.articleId }');"> <span class="ti-close"></span>
											</a></td>
										</tr>
									</c:forEach>
									<tr style="background-color: #FFF">
										<td colspan="6"><span>第${pageInfo.pageNum }/${pageInfo.pages}页</span> &nbsp;&nbsp; <span>总记录数：${pageInfo.total }&nbsp;&nbsp;每页显示:${pageInfo.pageSize}</span>
											&nbsp;&nbsp; <span> <c:if test="${pageInfo.hasPreviousPage }">
													<a href="javascript:void(0)" onclick="selectMenu('/article/list?cp=1&option=${option }');" disabled="true">[首页]</a>&nbsp;&nbsp;
											<a href="javascript:void(0)" onclick="selectMenu('/article/list?cp=${pageInfo.pageNum-1}&option=${option }');">[上一页]</a>&nbsp;&nbsp;
                                            </c:if> <c:if test="${pageInfo.hasNextPage}">
													<a href="javascript:void(0)" onclick="selectMenu('/article/list?cp=${pageInfo.pageNum+1}&option=${option }');">[下一页]</a>&nbsp;&nbsp;
						                    <a href="javascript:void(0)" onclick="selectMenu('/article/list?cp=${pageInfo.pages}&option=${option }');">[尾页]</a>&nbsp;&nbsp;</c:if>
										</span></td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<!--   Core JS Files   -->
<script>
	$(function() {
		$(":radio").click(function() {
			selectMenu('/article/list?option=' + $(this).val());
		});
		//radio
		var checked_raido = '${option }';
		if (!checked_raido == "") {
			$("input:radio[value=" + checked_raido + "]").attr("checked", "checked");
		}
	});
	function settingModel(id) {
		$('#myModal').modal({
			remote : '${pageContext.request.contextPath }/article/form?type=1&id=' + id
		});
	}
	$("#myModal").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	function addType() {
		var type = $("#newtype").val();
		if ($.trim(type) == "") {
			alert("请输入...");
		} else {
			$.get('${pageContext.request.contextPath }/article/typesave', {
				newtype : type
			}, function(data) {
				alert(data.error);
				$('#myModal').removeData("bs.modal");
				//              if (data.success) {
				//                  alert("配置成功！");
				//                  $("#myModal").modal('hide');
				//              } else {
				//                  alert(data.error);
				//              }
			});
		}
	}
	$('#myModal').on('show.bs.modal', function(e) {
		$(this).find('.modal-dialog').css({
			'margin-top' : function() {
				var modalHeight = $('#myModal').find('.modal-dialog').height();
				console.log(modalHeight);
				return ($(window).height() / 2 - (modalHeight / 2));
			}
		});
	});
</script>

</html>