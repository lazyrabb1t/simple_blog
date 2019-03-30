<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96" href="../assets/bootstrap-blog/img/favicon.png">
<title>GOINFOR</title>
<link href="../assets/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet" />
<link href="../assets/bootstrap-blog/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="../assets/bootstrap-blog/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../assets/bootstrap-fileinput/js/fileinput.min.js"></script>
<script type="text/javascript" src="../assets/bootstrap-fileinput/js/fileinput_locale_zh.js"></script>
</head>
<body>
	<div class="row" style="width: 500px; margin: 200px auto;">
		<form enctype="multipart/form-data">
			<input id="file-0" class="file" type="file" multiple data-min-file-count="1"> <br>
		</form>
	</div>
</body>
<script type="text/javascript">
	$("#file-0").fileinput({
		'allowedFileExtensions' : [ 'jpg', 'png', 'gif', 'jpeg' ],
		showUpload : true,//是否显示上传后的按钮  
		showBrowse : true,//是否显示上传前的上传按钮  
	});
</script>
</html>