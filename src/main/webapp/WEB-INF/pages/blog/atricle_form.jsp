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
					<div class="header">
						<h4 class="title">Blog Creation</h4>
					</div>
					<div class="content">
						<form action="" method="post" id="articleform">
							<input type="hidden" name="articleId" value="${article.articleId }">
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<input type="text" class="form-control border-input" placeholder="这里输入标题..." value="${article.tittle }" name="tittle" id="tittle">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<textarea id="editor" placeholder="" name="content">
										${article.content }</textarea>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label class="title">文章类型：</label>
										<c:forEach items="${typelist}" var="type" varStatus="vs">
											<label class="radio-inline"> <c:if test="${vs.index==0}">
													<input type="radio" name="belongType" id="inlineRadio1" value="${type.id }" checked="checked">
												</c:if> <c:if test="${vs.index!=0}">
													<input type="radio" name="belongType" id="inlineRadio1" value="${type.id }">
												</c:if> ${type.type }
											</label>
										</c:forEach>
										<!-- 										<label class="radio-inline"> -->
										<!-- 											<input type="radio" name="belongType" id="inlineRadio1" value="1" checked="checked"> -->
										<!-- 											SSM -->
										<!-- 										</label> -->
										<a href="javascript:void(0)" onclick="typeManagerModel();" title="新增分类"> <span class="ti-comment-alt"></span> &nbsp; <span style="font-size: 15px;">类型管理</span>
										</a>
									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 0px;">
								<div class="col-md-12">
									<div class="form-group">
										<div class="fileinput fileinput-new" data-provides="fileinput" id="exampleInputUpload">
											<div style="float: left;">
												<label class="title">文章背景：</label>
											</div>
											<div class="fileinput-new thumbnail" style="max-width: 90%; height: auto; float: left;">
												<c:if test="${not empty attachment}">
													<img id='picImg' style="" src="..${attachment.savepath }" alt="" />
												</c:if>
												<c:if test="${empty attachment}">
													<img id='picImg' style="" src="${pageContext.request.contextPath }/images/noimage.png" alt="" />
												</c:if>
											</div>
											<div class="fileinput-preview fileinput-exists thumbnail" style="float: left; max-width: 90%;"></div>
											<div style="margin-left: 80px;">
												<span class="btn2 btn-primary btn-file" style=""> <span class="fileinput-new">选择文件</span> <span class="fileinput-exists">换一张</span> <input type="file"
													name="pic1" id="picID" accept="image/gif,image/jpg,image/jpeg,image/x-png" />
												</span> <a href="javascript:;" class="btn2 btn-warning fileinput-exists" data-dismiss="fileinput">移除</a>
												<c:if test="${not empty attachment}">
													<span class="btn2 btn-danger fileinput-new" onclick="deleteAttachment('${article.articleId }');">删除</span>
												</c:if>
											</div>
										</div>
									</div>
								</div>
								<div class="text-center">
									<button type="button" onclick="submitArticle('publish');" class="btn btn-info btn-fill btn-wd">发布博客</button>
									<button type="button" onclick="submitArticle('save_as_draft');" class="btn btn-info btn-fill btn-wd">保存为草稿</button>
								</div>
						</form>
					</div>
				</div>
			</div>
		</div>
</body>
<script>
	$(function() {
		//Simditor富文本编辑器
		Simditor.locale = 'zh-CN';//设置中文
		var editor = new Simditor(
				{
					textarea : $('#editor'), //textarea的id
					placeholder : '这里输入文字...',
					toolbar : [ 'title', 'bold', 'italic', 'underline',
							'strikethrough', 'fontScale', 'color', '|', 'ol',
							'ul', 'blockquote', 'code', 'table', '|', 'link',
							'image', 'hr', '|', 'indent', 'outdent',
							'alignment' ], //工具条都包含哪些内容
					toolbarFloat : true,
					pasteImage : true,//允许粘贴图片
					defaultImage : '${pageContext.request.contextPath }/images/noimage.png',//编辑器插入的默认图片，此处可以删除
					upload : {
						url : '${pageContext.request.contextPath }/attachment/imgupload', //文件上传的接口地址
						//			 params: null, //键值对,指定文件上传接口的额外参数,上传的时候随文件一起提交
						fileKey : 'upload_file', //服务器端获取文件数据的参数名
						connectionCount : 1,
						leaveConfirm : '正在上传文件'
					}
				});
		$(".simditor input[type='file']").attr('accept',
				'image/jpg,image/jpeg,image/png,image/gif');
		// 		$(".simditor").height(666);
		// 		$(".simditor").css("overflow-y", "scroll");
		$(".simditor").css("min-height", "666px");
		$("pre").each(function() {

			$(this).text($(this).html());

		});
		//ajaxform
		var options = {
			beforeSubmit : showRequest, // pre-submit callback 
			success : showResponse, // post-submit callback 
			dataType : "json",
			resetForm : false
		};
		$('#articleform').ajaxForm(options);
		//radio
		var checked_raido = '${article.belongType }';
		if (!checked_raido == "") {
			$("input:radio[value=" + checked_raido + "]").attr("checked",
					"checked");
		}
		//模态窗体
		$("#myModal").on("hidden.bs.modal", function() {
			$(this).removeData("bs.modal");
		});
	});
	function showRequest() {
		if ($("#tittle").val() == "") {
			alert("请输入标题！");
			return false;
		} else {
			return true;
		}
	}
	function showResponse(data) {
		if (data.success) {
			alert("已保存");
		} else {
			alert(data.error);
		}
	}
	function submitArticle(type) {
		if (type == 'publish') {
			$('#articleform')
					.attr('action',
							'${pageContext.request.contextPath }/article/save?ispublish=1');
		} else {
			$('#articleform')
					.attr('action',
							'${pageContext.request.contextPath }/article/save?ispublish=0');
		}
		$("#articleform").submit();

	}

	function typeManagerModel() {
		$('#myModal').modal({
			remote : '${pageContext.request.contextPath }/article/typelist'
		});
	}
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
				//			  if (data.success) {
				//				  alert("配置成功！");
				//				  $("#myModal").modal('hide');
				//			  } else {
				//				  alert(data.error);
				//			  }
			});
		}
	}
	function deleteAttachment(articleId) {
		if (confirm("确定要删除该图片吗?")) {
			$
					.get(
							'${pageContext.request.contextPath }/attachment/deleteArticleAttachment',
							{
								id : articleId
							}, function(data) {
								alert(data.error);
								if (data.success) {
									$("#picImg").attr("src",
											"${pageContext.request.contextPath }/images/noimage.png");
								}
							});
		}
	}
</script>

</html>