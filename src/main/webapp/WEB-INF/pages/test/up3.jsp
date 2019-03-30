<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96" href="../assets/bootstrap-blog/img/favicon.png">
<title>GOINFOR</title>
<link href="../assets/fileinput/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/fileinput/css/bootstrap-fileinput.css" rel="stylesheet">
<script type="text/javascript" src="../assets/bootstrap-blog/js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="../assets/fileinput/js/bootstrap-fileinput.js"></script>
</head>
<body>
	<div class="row" style="margin-top: 0px;">
		<div class="col-md-12">
			<div class="form-group" id="uploadForm" enctype='multipart/form-data'>
				<div class="h4">图片预览</div>
				<div class="fileinput fileinput-new" data-provides="fileinput" id="exampleInputUpload">
					<div class="fileinput-new thumbnail" style="width: 200px; height: auto; max-height: 150px;">
						<img id='picImg' style="width: 100%; height: auto; max-height: 140px;" src="../images/noimage.png" alt="" />
					</div>
					<div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
					<div>
						<span class="btn btn-primary btn-file"> <span class="fileinput-new">选择文件</span> <span class="fileinput-exists">换一张</span> <input type="file" name="pic1" id="picID"
							accept="image/gif,image/jpeg,image/x-png" />
						</span> <a href="javascript:;" class="btn btn-warning fileinput-exists" data-dismiss="fileinput">移除</a>
					</div>
				</div>
			</div>
		</div>
</body>
</html>