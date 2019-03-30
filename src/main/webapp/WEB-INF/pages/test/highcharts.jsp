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
<script type="text/javascript" src="../assets/Highcharts-6.0.7/highcharts.js"></script>
<script type="text/javascript" src="../assets/Highcharts-6.0.7/data.js"></script>

<script type="text/javascript" src="../assets/Highcharts-6.0.7/oldie.js"></script>
<script type="text/javascript" src="../assets/Highcharts-6.0.7/series-label.js"></script>
</head>
<body>
	<div id="container" style="min-width: 400px; height: 400px;"></div>
	<button onclick="upd();">nihao</button>
	<script type="text/javascript">
		var options = {
			title : {
				text : '2010 ~ 2016 年太阳能行业就业人员发展情况'
			},
			subtitle : {
				text : '数据来源：thesolarfoundation.com'
			},
			xAxis : {
				type : 'datetime',
				tickInterval : 2 * 24 * 3600 * 1000, // 坐标轴刻度间隔为一星期
				// 时间格式化字符
				// 默认会根据当前的刻度间隔取对应的值，即当刻度间隔为一周时，取 week 值
				dateTimeLabelFormats : {
					day : '%m-%d'
				}
			},
			yAxis : {
				title : {
					text : '就业人数'
				}
			},
			legend : {//图例
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle'
			},
			plotOptions : {
				series : {
					pointStart : Date.UTC(2018, 1, 5), // 开始值
					pointInterval : 24 * 3600 * 1000
				// 间隔一天
				}
			},
			series : [/*{
			                        name: '安装，实施人员',
			                        data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175],
			        //              pointStart: Date.UTC(2014, 0, 10),
			        //              pointEnd:Date.UTC(2014,0,17),
			        //              pointInterval: 24 * 3600 * 1000
			                    }*/],
			tooltip : {//数据提示框
				shared : true,
				crosshairs : true,//启用竖直方向准星线
			},
		};
		options.plotOptions.series.pointStart =  getPointStart();
		// options.plotOptions[0].series[0].pointStart = tempPointStart;
		var chart = Highcharts.chart('container', options);
		Load_SeriesData();
		function Load_SeriesData() {
			chart.showLoading("Loading....");
			$
					.ajax({
						url : '../main/getcharts',
						type : 'post',
						dataType : 'json',
						contentType : "application/x-www-form-urlencoded; charset=utf-8",
						success : function(Data) {
							console.log(Data);
							for (i = 0; i < Data.length; i++) {

								chart.addSeries(Data[i]);
							}
							chart.redraw();
							chart.hideLoading("Loading....");
						}
					});
		}
		function upd() {
			chart.showLoading("Loading....");
			$
					.ajax({
						url : '../main/getcharts',
						type : 'post',
						dataType : 'json',
						contentType : "application/x-www-form-urlencoded; charset=utf-8",
						success : function(Data) {
							console.log(Data);
							chart.update({
								series : Data
							});
							chart.hideLoading("Loading....");
						}
					});
		}
		function getPointStart() {
			var date1 = new Date();
			var date2 = new Date(date1);
			date2.setDate(date1.getDate() - 29);
			var tempPointStart = Date.UTC(date2.getFullYear(),date2.getMonth(),date2.getDate());
			console.log(tempPointStart);
			return tempPointStart;
		}
	</script>
</body>
</html>