<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");

if (id != null && !"admin".equals(id)) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/members?serverTimezone=UTC", "root", "1234");
        PreparedStatement ps = conn.prepareStatement("DELETE FROM members WHERE id=?");
        ps.setString(1, id);
        ps.executeUpdate();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.print("刪除失敗：" + e.getMessage());
    }
}
response.sendRedirect("memberManage.jsp");
%>
