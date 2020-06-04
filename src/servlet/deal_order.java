package servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javabean.db_conn;
import javabean.flight;

public class deal_order extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession();
		if(session.getAttribute("user_id")!=null) {
			String user_id=session.getAttribute("user_id").toString();
			String flight_id=req.getParameter("flight_id");
			String position = req.getParameter("position");
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String curdate = LocalDateTime.now().format(formatter);
			formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
			String ID = user_id + LocalDateTime.now().format(formatter);
			int cnt = Integer.parseInt(req.getParameter("cnt"));
			int cnt1 = Integer.parseInt(req.getParameter("cnt1"));
			int cnt2 = Integer.parseInt(req.getParameter("cnt2"));
			int cnt3 = Integer.parseInt(req.getParameter("cnt3"));
			int all = 120;
			int passenger_num = 0;
			String pos = "";String sel = "";
			//System.out.println(position);
			//System.out.println(position.length());
			for(int i=0;i<all;i++){
				String index = "seat" + i;
				String nstate = req.getParameter(index);
				//System.out.println(nstate + i);
				if(position.charAt(i) == '1'){
					pos += "1"; sel += "0";
				}
				else if(nstate.equals("+")){
					if(i%20<3) cnt1--;
					else if(i%20>14) cnt3--;
					else cnt2--;
					pos += "1"; sel += "1";
					passenger_num++;
				}
				else{
					pos += "0"; sel += "0";
				}
			}
			if(flight_id!="") {
				db_conn conn=new db_conn();
				String sql = "update flight set position = '" + pos +"', fir_seat = '"+ cnt1 +"',bus_seat = '" + cnt2 + "',eco_seat = '" + cnt3 + "' where number = '" + flight_id + "'";
				//System.out.println(sql);
				int res = conn.Update(sql);
				if(res == 1){
					System.out.println("修改flight表成功");
				}
				sql="insert into orderlist values('"+flight_id+"',"+passenger_num+",'"+curdate+"','"+sel+"','"+user_id+"','"+ID+"')";
				Integer result =conn.executeInsert(sql);
				conn.closeDB();
				//System.out.println(result);
				if(result.equals(1)) {
					resp.sendRedirect("default/order_list.jsp");
				}else {
					resp.sendRedirect("default/order.jsp");
					System.out.println(sql);
				}
				
			}else {
				resp.sendRedirect("default/order.jsp");
			}
			
		}else {
			resp.sendRedirect("default/order.jsp");
		}	
		
	}
}
