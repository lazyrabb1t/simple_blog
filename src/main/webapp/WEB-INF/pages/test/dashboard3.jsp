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
									12399
								</div>
							</div>
						</div>
						<div class="footer">
							<hr />
							<div class="stats">
								<i class="ti-time"></i> last day 19 times
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
									442
								</div>
							</div>
						</div>
						<div class="footer">
							<hr />
							<div class="stats">
								<i class="ti-calendar"></i> Last day 9 times
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
									23
								</div>
							</div>
						</div>
						<div class="footer">
							<hr />
							<div class="stats">
								<i class="ti-mouse"></i> total article hits 199 times
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
									50
								</div>
							</div>
						</div>
						<div class="footer">
							<hr />
							<div class="stats">
								<i class="ti-clipboard"></i> Types 10
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
						<h4 class="title">Users Behavior</h4>
						<p class="category">24 Hours performance</p>
					</div>
					<div class="content">
						<div id="container" style="min-width: 400px; height: 400px;"></div>
						<div class="message"></div>
						<script type="text/javascript">
						var chart = null;
						//获取 CSV 数据并初始化图表
						
//  						$.getJSON('https://data.jianshukeji.com/jsonp?filename=csv/analytics.csv&callback=?', function (csv) {
// 							console.log(csv);
						 chart = Highcharts.chart('container', {
// 						     data: {
// 						         csv: csv
// 						     },
						     title: {
						         text: '  '
						     },
						     subtitle: {
						         text: ''
						     },
						     xAxis: {
						         categories: ['2018-03-03', '2018-03-04', '2018-03-05', '2018-03-06', '2018-03-07', '2018-03-08', '2018-03-09', '2018-03-10'],
						         tickWidth: 0,
						            gridLineWidth: 1,
						            labels: {
						                align: 'left',
						                x: 3,
						                y: -3
						            },dateTimeLabelFormats: {
						                week: '%Y-%m-%d'
						            }
						     },
						     series: [{
						         name: 'Installation',
						         data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
						     }, {
						         name: 'Manufacturing',
						         data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434]
						     }],
						     yAxis: { //轴，放置在左边（默认在坐标）
						         title: {
						             text: null
						         },
						         labels: {
						             align: 'center',
						             x: 0,
						             y: 5
// 						             format: '{value:.,0f}'
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
						     tooltip: {
						         shared: true,
						         crosshairs: true,
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
					                href: ''
					         },
						     plotOptions: {//数据列配置
						         series: {//针对某个数据列有效
						             cursor: 'pointer',
// 						             point: {
// 						                 events: {
// 						                     // 数据点点击事件
// 						                     // 其中 e 变量为事件对象，this 为当前数据点对象
// 						                     click: function (e) {
// 						                         $('.message').html( Highcharts.dateFormat('%Y-%m-%d', this.x) + ':<br/>  访问量：' +this.y );
// 						                     }
// 						                 }
// 						             },
// 						             marker: {
// 						                 lineWidth: 1
// 						             }
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