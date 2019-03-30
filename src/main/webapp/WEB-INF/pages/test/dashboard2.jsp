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
								<i class="ti-calendar"></i> Last day ${lastuv }
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
								<i class="ti-clipboard"></i> Types ${types }
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<pre id="csv" style="display: none">
Day,访问量（PV）,访问用户（UV）
2018-02-28,3,1
2018-03-01,12,2
2018-03-02,33,1
2018-03-03,0,0
2018-03-04,0,0
2018-03-05,0,0
2018-03-06,0,0
2018-03-07,0,0
2018-03-08,0,0
2018-03-09,0,0
2018-03-10,0,0
2018-03-11,0,0
2018-03-12,0,0
2018-03-13,0,0
2018-03-14,0,0
2018-03-15,0,0
2018-03-16,0,0
2018-03-17,0,0
2018-03-18,0,0
2018-03-19,0,0
2018-03-20,0,0
2018-03-21,0,0
2018-03-22,0,0
2018-03-23,0,0
2018-03-24,0,0
2018-03-25,0,0
2018-03-26,3,1
2018-03-27,19,2
2018-03-28,2,1
2018-03-29,2,1
2018-03-30,1,1
                    </pre>
			<div class="col-md-12">
				<div class="card">
					<div class="header">
						<h4 class="title">Users Behavior</h4>
						<p class="category">24 Hours performance</p>
						<a onclick="alert('ss');chart.redraw();">sss</a>
					</div>
					<div class="content">
						<div id="container" style="min-width: 400px; height: 400px;"></div>
						<div class="message"></div>
						<script type="text/javascript">
						var chart = null;
						//获取 CSV 数据并初始化图表
// 						console.log("333333");
						
//  						$.getJSON('../main/getVisitMessage', function (csv) {
//  							console.log("2222222");
// 							console.log(csv);
						 chart = Highcharts.chart('container', {
						     data: {
						         csv: document.getElementById('csv').innerHTML
						     },
						     title: {
						         text: '  '
						     },
						     subtitle: {
						         text: ''
						     },
						     xAxis: {
						         tickInterval: 2 * 24 * 3600 * 1000, // 坐标轴刻度间隔为一星期
						         tickWidth: 0,//坐标轴刻度线的宽度
						         gridLineWidth: 0,//网格线线条宽度，当设置为 0 时则不显示网格线。
						         labels: {
						             align: 'left',
						             x: -18,
						             y: 20
						         },
						         // 时间格式化字符
						         // 默认会根据当前的刻度间隔取对应的值，即当刻度间隔为一周时，取 week 值
						         dateTimeLabelFormats: {
						             day: '%m-%d'
						         }
						     },
						     yAxis: { //轴，放置在左边（默认在坐标）
						         title: {
						             text: null
						         },
						         labels: {
						             align: 'center',
						             x: 0,
						             y: 5,
						             format: '{value:.,0f}'
						         },
						         showFirstLabel: false //是否显示坐标轴的第一个标签
						     },
						     legend: { //图例
						    	 enabled: false,//图例开关
// 						         align: 'right',
// 						         verticalAlign: 't',
// 						         y: 10,
// 						         floating: false,
// 						         borderWidth: 0
						     },
						     tooltip: {//数据提示框
						         shared: true,
						         crosshairs: true,//启用竖直方向准星线
						         // 时间格式化字符
						         // 默认会根据当前的数据点间隔取对应的值
						         // 当前图表中数据点间隔为 1天，所以配置 day 值即可
						         dateTimeLabelFormats: {
						             day: '%Y-%m-%d'
						         }
						     },
						     credits: {//版权信息
						    	 enabled: false,
					                text: 'lazyRabbit',
					                href: 'http://lazyrabbit.tech/'
					         },
						     plotOptions: {//数据列配置
						         series: {//针对某个数据列有效
						             cursor: 'pointer',
						             marker: {
						                 lineWidth: 1
						             }
						         }
						     }
						 });
						</script>
					</div>

				</div>
			</div>
		</div>
	</div>
</body>
</html>