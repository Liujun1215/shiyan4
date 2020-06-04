
<%@page import="java.sql.ResultSet"%>
<%@page import="javabean.db_conn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//添加URL session ，作为用户登录后跳转回来的依据,登录servlet中已经写了判断程序，如果有url_cookie，就跳转到url_cookie，如果没有，就跳转到用户中心
	session.setAttribute("url", request.getRequestURI());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>订单列表</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common.css" rel="stylesheet">
<link href="css/corptravel.css" rel="stylesheet">
<link href="css/enterprise.css" rel="stylesheet">
<link href="css/iconfont.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body class="bg-body">
<%
	int row = 6; int col = 20;
	if(session.getAttribute("user_id")==null){
		response.sendRedirect("/airline-booking-system/index/login_reg.jsp");
		return ;
	}
%>
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

	<!-- list start -->
	<div class="container bg-gray-eee box-shadow mar-bottom-10"
		style="padding-right: 0px; padding-left: 0px; position: relative; margin-top: 120px;">
		<table border="0" cellspacing="0" cellpadding="0"
			class="table table-hover table-striped font12 table-bordered v-align-top">
			<tr>
				<th style="width:10%;">航班号</th>
				<th style="width:5%;">人数</th>
				<th style="width:10%;">订票时间</th>
				<th style="width:60%;">舱位</th>
				<th style="width:10%;">乘客</th>
				<th style="width:5%">操作</th>
			</tr>
			
			<%
				db_conn conn=new db_conn();
				String user_id = session.getAttribute("user_id").toString();
				String sql="select * from orderlist where usrname ='"+user_id+"'";
				ResultSet res=conn.executeQuery(sql);
				while(res.next()){
					String flight_id = res.getString("number");
					String airlineImg = "/airline-booking-system/default/images/air/" + flight_id.substring(0,2) + ".png";
					
			%>
			
			<tr>
				<td>
					<img src="<%=airlineImg%>" width="24" height="24"><h1><%=res.getString(1) %></h1>
					<span class="gray-999 font12 mar-left-10">机型：空客320（中）</span>

				</td>
				<td><h2><%=res.getString(2) %></h2></td>
				<td><h4><%=res.getString(3) %></h4></td>
				<td><%
					String sel = res.getString(4);
					int itr = 0;
					for(int i=0;i<row;i++){
							for(int j=0;j<col;j++){
							int chr = 'A' + j;
							String pos = String.valueOf((char)chr) + (i+1);
							if(sel.charAt(itr) == '1'){%>
								<input type="button" value="<%=pos%>" class="btn btn-xs btn-info" />
							<%}else if(sel.charAt(itr) == '0'){ %>
							<input type="button" value ="<%=pos%>" class="btn btn-xs btn-default disabled"/>
							<%		} itr++;}if(i == 2)%> </br>
							</br>
					<%	}%>
				</td>
				<td><h3><%=res.getString(5) %></h3></td>
				<td>
					<form action="../cancel_order" method="post">
						<input type="submit" value="取消" class="btn btn-warning"/>
						<input type="hidden" value="<%=res.getString(6)%>" name ="hashindex" />
						<input type="hidden" value="<%=res.getString(1)%>" name ="flight_id" />
						<input type="hidden" value="<%=res.getString(4)%>" name ="sel" />
					</form>
				</td>
			</tr>
			
			<%
				}
			%>

		</table>
	</div>

	<!-- list end -->
</body>
</html>