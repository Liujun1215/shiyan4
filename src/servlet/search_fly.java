package servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import javabean.db_conn;
import javabean.flight;

public class search_fly extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//get提交为非法操作，直接返回被session记忆的页面即可
		HttpSession session = req.getSession();
		String url=null;
		if(session.getAttribute("url")!=null) {
			url=session.getAttribute("url").toString();
		}else {
			url="default/index.jsp";
		}
		resp.sendRedirect(url);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		//HttpSession session = req.getSession();
		String url=null;
		/*
		 * if(session.getAttribute("url")!=null) {
		 * url=session.getAttribute("url").toString(); }else {
		 */
			url="default/index.jsp";
		
		String departure=null;
		String destination=null;
		String depart_date = null;
		String sort_rule = null;
		departure=req.getParameter("departure");
		destination=req.getParameter("destination");
		depart_date = req.getParameter("depart_date");
		sort_rule = req.getParameter("sort_rule");

		String sql=null;
		if(departure==""&&destination=="" && depart_date == "") {
			//如果始发地和目的地都为空则跳转回原页面
			resp.sendRedirect(url);
		}
		else{
			sql = "select * from flight where ";
			boolean isFirst = true;
			if(departure != ""){
				sql =  sql + "departure = '" + departure + "'";
				isFirst = false;
			}
			if(destination != ""){
				if(!isFirst) sql = sql + " and ";
				sql = sql + "destination = '" + destination + "'";
				isFirst = false;
			}
			if(depart_date != ""){
				if(!isFirst) sql = sql + " and ";
				sql = sql + "dep_date = '" + depart_date + "'";
			}
			if(sort_rule != ""){
				if(sort_rule.equals("最短时间")) sql = sql + " order by timeoflight";
				else sql = sql + "order by first_class";
			}
			db_conn conn=new db_conn();
			ArrayList<flight> flightlist = new ArrayList<flight>();

			ResultSet res=conn.executeQuery(sql);
			try {
				while (res.next()) {
					flight flight_info=new flight();
					flight_info.setF_n(res.getString(1));
					flight_info.setF_s_a(res.getString(4));
					flight_info.setF_a_a(res.getString(5));
					flight_info.setF_d_t(res.getString(6));
					flight_info.setF_a_t(res.getString(7));
					flight_info.setF_f_c_p(res.getString(8));
					flight_info.setF_s_c_p(res.getString(9));
					flight_info.setF_t_c_p(res.getString(10));
					flight_info.setFir_cnt(res.getString("fir_seat"));
					flight_info.setBus_cnt(res.getString("bus_seat"));
					flight_info.setEoc_cnt(res.getString("eco_seat"));
					flight_info.setDepart_date(res.getString("dep_date"));
					flight_info.setCompany(res.getString("airlinecompany"));
					flight_info.setFlytime(res.getString("timeoflight"));
					flightlist.add(flight_info);
				}
				req.setAttribute("flightlist", flightlist);
			} catch (SQLException e) {
				System.out.println("错误信息："+e);
			}finally {
				conn.closeDB();
			}
			//resp.sendRedirect("default/search.jsp");
			req.getRequestDispatcher("default/search.jsp").forward(req, resp);
		}
	}
}
