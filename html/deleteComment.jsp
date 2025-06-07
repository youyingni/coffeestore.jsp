<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");

if (id != null) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
        PreparedStatement ps = conn.prepareStatement("DELETE FROM comment WHERE commentId=?");
        ps.setInt(1, Integer.parseInt(id));
        ps.executeUpdate();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("刪除失敗：" + e.getMessage());
    }
}
response.sendRedirect("commentManage.jsp");
%>
