<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String no = request.getParameter("no");

if (no != null) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
        PreparedStatement ps = conn.prepareStatement("DELETE FROM productss WHERE no=?");
        ps.setString(1, no);
        ps.executeUpdate();
        ps.close(); conn.close();
    } catch (Exception e) {
        out.print("刪除失敗：" + e.getMessage());
    }
}
response.sendRedirect("productManage.jsp");
%>
