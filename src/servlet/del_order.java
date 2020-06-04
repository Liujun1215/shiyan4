package servlet;
import javabean.db_conn;
import javabean.get_md5;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

public class del_order extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        PrintWriter out = resp.getWriter();
        out.println("��ʹ��Ĭ�Ϸ�ʽ�ύ���ݣ���Ҫ���ԷǷ�����");
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        HttpSession session = req.getSession();
        String orderid = req.getParameter("hashindex");
        String flight_id = req.getParameter("flight_id");
        String sel = req.getParameter("sel");
        int del1 = 0,del2 = 0,del3 = 0,cnt1 =0 ,cnt2 = 0,cnt3 = 0;
        String npos = "", pos = "";
        for(int i=0;i<120;i++){
            if(sel.charAt(i) == '1'){
                if(i%20<3) del1++;
                else if(i%20>14) del3++;
                else del2++;
            }
        }

        db_conn conn = new db_conn();

        String sql = "delete from orderlist where orderid = '"+ orderid +"'";
        int result = conn.executeDelete(sql);
        if(result ==  0) System.out.println("delete orderlist ʧ��");
        sql = "select * from flight where number = '" + flight_id + "'";
        System.out.println(sql);
        try {
            ResultSet res = conn.executeQuery(sql);
            if(res.next()) {
                cnt1 = res.getInt("fir_seat");
                cnt2 = res.getInt("bus_seat");
                cnt3 = res.getInt("eco_seat");
                pos = res.getString("position");
            }
        }catch(SQLException e) {
            System.out.println("���ֲ���Ԥ���Դ��󣬴�����Ϣ���£�"+e);
        }
        cnt1 += del1; cnt2 += del2; cnt3 += del3;
        for(int i=0;i<120;i++){
            if(pos.charAt(i) == '0') npos += "0";
            else if(sel.charAt(i) == '1') npos += "0";
            else npos += "1";
        }
        sql = "update flight set fir_seat = '" + cnt1 + "', bus_seat = '" + cnt2 + "', eco_seat = '" + cnt3 + "', position = '" + npos + "' where number = '" + flight_id + "'";
        System.out.println(sql);
        result = conn.Update(sql);
        if(result == 0) System.out.println("update flightʧ��");
        resp.sendRedirect("default/order_list.jsp");
    }
}
