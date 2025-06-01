<%@ page import="java.sql.*" %>
<%
  request.setCharacterEncoding("UTF-8");
  String no = request.getParameter("no");
  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "500608");
    PreparedStatement ps = conn.prepareStatement("DELETE FROM cart WHERE no = ?");
    ps.setInt(1, Integer.parseInt(no));
    int row = ps.executeUpdate();
    if (row > 0) {
      out.print("success");
    } else {
      out.print("fail");
    }
    conn.close();
  } catch (Exception e) {
    out.print("error: " + e.getMessage());
  }
%>