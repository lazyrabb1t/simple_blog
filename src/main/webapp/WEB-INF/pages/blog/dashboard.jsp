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
			<div class="col-lg-3 col-sm-6">
				<div class="card">
					<div class="content">
						<div class="row">
							<div class="col-xs-5">
								<div class="icon-big icon-warning text-center">
									<i class="ti-world"></i>
								</div>
							</div>
							<div class="col-xs-7">
								<div class="numbers">
									<p>PV</p>
									${pv }
								</div>
							</div>
						</div>
						<div class="footer">
							<hr />
							<div class="stats">
								<i class="ti-time"></i> last day ${lastpv }
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3 col-sm-6">
				<div class="card">
					<div class="content">
						<div class="row">
							<div class="col-xs-5">
								<div class="icon-big icon-success text-center">
									<i class="ti-pulse"></i>
								</div>
							</div>
							<div class="col-xs-7">
								<div class="numbers">
									<p>UV</p>
									${uv }
								</div>
							</div>
						</div>
						<div class="footer">
							<hr />
							<div class="stats">
								<i class="ti-calendar"></i> last day ${lastuv }
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3 col-sm-6">
				<div class="card">
					<div class="content">
						<div class="row">
							<div class="col-xs-5">
								<div class="icon-big icon-danger text-center">
									<i class="ti-heart"></i>
								</div>
							</div>
							<div class="col-xs-7">
								<div class="numbers">
									<p>Liked</p>
									${liked }
								</div>
							</div>
						</div>
						<div class="footer">
							<hr />
							<div class="stats">
								<i class="ti-mouse"></i> total article hits ${hits }
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3 col-sm-6">
				<div class="card">
					<div class="content">
						<div class="row">
							<div class="col-xs-5">
								<div class="icon-big icon-info text-center">
									<i class="ti-book"></i>
								</div>
							</div>
							<div class="col-xs-7">
								<div class="numbers">
									<p>Articles</p>
									${articles }
								</div>
							</div>
						</div>
						<div class="footer">
							<hr />
							<div class="stats">
								<i class="ti-clipboard"></i> types ${types }
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="header">
						<h4 class="title">Monitor</h4>
						<p class="category">last thirty days performance</p>
					</div>
					<div class="content">
						<div id="container" style="min-width: 400px; height: 400px;"></div>
					</div>

				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		var options = {
			title : {
				text : null
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
					text : null
				}
			},
			legend : {//图例
				enabled : false,//图例开关
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle'
			},
			plotOptions : {
				series : {
					pointStart : Date.UTC(2018, 0, 1), // 开始值
					pointInterval : 24 * 3600 * 1000
				// 间隔一天
				}
			},
			credits : {//版权信息
				enabled : false,
				text : 'lazyRabbit',
				href : 'http://lazyrabbit.tech/'
			},
			series : [],
			tooltip : {//数据提示框
				shared : true,
				crosshairs : true,//启用竖直方向准星线
				dateTimeLabelFormats : {
					day : '%Y-%m-%d'
				}
			}
		};
		var chart = null;
		Load_SeriesData();
		function Load_SeriesData() {
			options.plotOptions.series.pointStart = getPointStart();
			chart = Highcharts.chart('container', options);
			chart.showLoading("Loading....");

			$.ajax({
				url : '${pageContext.request.contextPath }/main/getcharts',
				type : 'post',
				dataType : 'json',
				success : function(Data) {
					console.log(Data);
					for (i = 0; i < Data.length; i++) {
						chart.addSeries(Data[i]);
					}
					//                     chart.update({
					//                         series : Data
					//                     });
					chart.hideLoading("Loading....");
				}
			});
		}
		function getPointStart() {
			var date1 = new Date();
			var date2 = new Date(date1);
			date2.setDate(date1.getDate() - 29);
			var tempPointStart = Date.UTC(date2.getFullYear(),
					date2.getMonth(), date2.getDate());
			console.log(tempPointStart);
			return tempPointStart;
		}
	});
</script>
</html>