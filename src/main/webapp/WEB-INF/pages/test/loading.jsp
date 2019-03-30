<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" sizes="96x96" href="../images/carrot03.png">
<title>Go In 4</title>
<script type="text/javascript" src="../js/jquery-1.10.2.js"></script>
<style>
ul {
	width: 180px;
	margin: auto;
	margin-top: 60px;
	list-style: none;
	padding: 0;
	-moz-box-shadow: 0px 0px 4px 0px rgba(0, 0, 0, 0.37);
	box-shadow: 0px 0px 4px 0px rgba(0, 0, 0, 0.37);
}

ul li {
	width: 180px;
	height: 180px;
	line-height: 176px;
	text-align: center;
	float: left;
}

ul li img {
	vertical-align: middle;
}

li:nth-child(1) {
	background-color: #1ABC9C;
}
</style>
</head>
<body>
	<ul>

		<li id="loadd"><img src="../images/svg-loaders/bars.svg" width="40" alt=""></li>
	</ul>
	<button onclick="oper();">start</button>
	<button onclick="oper2();">stop</button>
	<script>
		function oper() {
$("#loadd").show();
		}
	      function oper2() {
	    	  $("#loadd").hide();
	    	          }
	</script>
</body>
</html>