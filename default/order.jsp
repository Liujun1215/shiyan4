<%@page import="javabean.db_conn"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//添加URL session ，作为用户登录后跳转回来的依据,登录servlet中已经写了判断程序，如果有url_cookie，就跳转到url_cookie，如果没有，就跳转到用户中心
	session.setAttribute("url", request.getRequestURI());
%>
<%! 
	String flight_id=null;
	String grade=null;
	String grade_character=null;
	String s_p=null;//起飞地点
	String e_p=null;//到达地点
	String s_a=null;//起飞机场
	String e_a=null;//目的机场
	String t_t=null;//起飞时间
	String l_t=null;//到达时间
	String position = null; //位置
	int col,row,cnt,cnt1,cnt2,cnt3,all = 120;
%>
<%
	flight_id=request.getParameter("flight_id");
	System.out.println(flight_id);
%>
<%
	
db_conn conn=new db_conn();
String sql="select * from flight where number ='"+flight_id+"'";
ResultSet res=conn.executeQuery(sql);
if(res.next()){	
	s_p=res.getString(2);
	e_p=res.getString(3);
	s_a=res.getString(4);
	e_a=res.getString(5);
	t_t=res.getString(6);
	l_t=res.getString(7);
	cnt1 = Integer.parseInt(res.getString(11));
	cnt2 = Integer.parseInt(res.getString(12));
	cnt3 = Integer.parseInt(res.getString(13));
	cnt = cnt1 + cnt2 + cnt3;
	col = Integer.parseInt(res.getString(15));
	position = res.getString(16);
}

%>


<%@ include file="verify_login.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>订单</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/common.css" rel="stylesheet">
	<link href="css/corptravel.css" rel="stylesheet">
	<link href="css/enterprise.css" rel="stylesheet">
	<link href="css/iconfont.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type = "text/javascript">
		function onseatclick(u) {
			u.className = "btn btn-xs btn-success";
			var tmp = document.getElementsByName("sea" + u.name);

			tmp[0].value = "+";
		}
	</script>
</head>
<body class="bg-body">
	<!-- header -->
	<nav class="navbar navbar-default navbar-fixed-top bg-white">
		<nav class="navbar navbar-default"
			style="min-height: 30px; line-height: 30px; margin-bottom: 0px; border-radius: 0;">
			<div class="container font12">

				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
						aria-expanded="false">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
				</div>
				<ul class="nav navbar-nav nav-top-small" style="margin-left: -15px;">
					<li class="dropdown">
						<% if(session.getAttribute("user_id")!=null){ %>
							<a href="javacript:none" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
								您好，<%=session.getAttribute("user_id").toString() %>
								<span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
								<li><a href="logout.jsp">退出</a></li>
							</ul>
						<%}else{ %>
							<a href="../user_center" class="dropdown-toggle"  role="button" aria-haspopup="true" aria-expanded="false">
								请登录！
								
							</a>
						<%} %>
					</li>
				</ul>
			</div>
		</nav>


		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
			</div>


			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li class="active"><a href="index.jsp"><i
							class="icon iconfont icon-nav-block font24">&#xe620;</i>首页</a></li>
					<li><a href="/airline-booking-system/default/order_list.jsp"><i
							class="icon iconfont icon-nav-block font24">&#xe61c;</i> 订单</a></li>
				</ul>
			</div>

		</div>
	</nav>
	<!-- header end -->
	
	<!-- content start -->

	<form action="../add_order" method="post" >
		<input type="hidden" name="flight_id" value="<%=flight_id %>">
		<input type="hidden" name="cnt" value="<%=cnt%>">
		<input type="hidden" name="cnt1" value="<%=cnt1%>">
		<input type="hidden" name="cnt2" value="<%=cnt2%>">
		<input type="hidden" name="cnt3" value="<%=cnt3%>">
		<input type="hidden" name="position" value="<%=position%>">
		<div class="container bg-gray-eee box-shadow mar-bottom-30" style="padding-right: 0px; padding-left: 0px; position: relative; margin-top: 120px;">
		<div class="col-sm-7 container bg-white  pad-bottom-10" style="margin-top: 30px; margin-bottom: 30px;">

			<!-- 选坐信息 -->
			<h4>选座您的座位</h4>
			<%
				System.out.println("order.jsp debug " + flight_id);
				row = all / col;
				int itr = 0;
				for(int i=0;i<col;i++){
					for(int j=0;j<row;j++){
						int chr = 'A' + j;
						String pos = String.valueOf((char)chr) + (i+1);
						if(position.charAt(itr) == '0'){
							String bclass = "btn btn-xs ";
							if(j < 3)bclass = bclass + "btn-warning";
							else if(j>14) bclass = bclass + "btn-danger";
							else bclass = bclass + "btn-primary";
			%>
			<input type="button" value="<%=pos%>" class="<%=bclass%>" name="<%="t"+itr%>"  onclick="onseatclick(this)"/>
			<input type="hidden" name="<%="seat"+itr%>" value="-">
			<%			}else if(position.charAt(itr) == '1'){ %>
						<input type="button" value ="<%=pos%>" class="btn btn-xs btn-default disabled" name="<%="t"+itr%>"/>
						<input type="hidden" name="<%="seat"+itr%>" value="-">
			<%		} itr++;}if(i == 2)%> </br>
			</br>
			<%	}%>


		</div>
		<div class="col-sm-5 bg-gray-eee">
			<div style="margin-left: -15px;">
				<h4 style="overflow: hidden; margin-left: 10px;">
					<span style="display: block; float: left;"></span>
					<span style="display: block; float: left; margin-left: 200px;"><%=s_p %>-<%=e_p %></span>
					<span
						style="display: block; float: right; color: #999; font-size: 14px; margin-right: 5px;"></span>
				</h4>
			</div>
			<div style="overflow: hidden; margin-bottom: 20px;">
				<div class="flight-from" style="float: left;">
					<span class="time text-center"><%=t_t %></span><br /> <span
						class="text-center"><%=s_a %></span>
				</div>
				<div class="flight-info" style="float: left; margin-left: 100px;">
					<img src="images/a.png"> <span class="font12 gray-999">2h35m</span>
					<img src="images/b.png"><br /> <img src="images/c.png" class="mar-left-10"> <span
						class="text-center font12 gray-999">实际乘坐<%=flight_id %></span><br /> <span
						class="airline-direct"></span> <span class="arrow"></span>
				</div>
				<div class="flight-to" style="float: right;">
					<span class="time text-center"><%=l_t %></span><br /> <span
						class="text-center"><%=e_a %></span>
				</div>
			</div>
			<div>
				<div class="tuigaiqian" style="cursor: pointer; color: #337ab7;">退改签说明</div>
				<div class="instruction">
					<table class="table table-bordered" style="height: 150px;">
						<tr>
							<td>成人票</td>
							<td>退票扣费</td>
							<td>改期加收手续费</td>
							<td>签转</td>
						</tr>
						<tr>
							<td>起飞前24小时之前</td>
							<td>￥169/人</td>
							<td>￥368/人</td>
							<td>可以签转</td>
						</tr>
						<tr>
							<td>起飞前24小时之后</td>
							<td>￥338/人</td>
							<td>￥368/人</td>
							<td>可以签转</td>
						</tr>
					</table>
				</div>
			</div>


		</div>

	</div>
		<div class="text-center mar-top-10" style="margin-bottom: 20px;">
				<input type="submit" value="提交订单" class="btn btn-danger mar-top-20">
		</div>
	</form>

	<!-- content end -->
</body>
</html>