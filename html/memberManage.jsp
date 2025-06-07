<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>會員管理</title>
  <link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap" rel="stylesheet">
 
  <style>
    body { font-family: "LXGW WenKai Mono TC", monospace; background-color: #f5f5f5; padding: 30px; }
    table { width: 100%; border-collapse: collapse; background-color: #fff; }
    th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
    th { background-color: #3a2a20; color: #fff; }
    h1 { text-align: center; }
    a.button { padding: 5px 10px; background-color: #ff0000; color: white; text-decoration: none; border-radius: 4px; }
    a.button:hover { background-color: #2d3f54;color: #ffff00; }
    .title{font-size: 35px;}
  </style>
</head>
<body>

<h1 class="title">會員管理</h1>
<a href="login1.jsp" class="button">回上一頁</a>
<br>
<br>
<table>
  <tr>
    <th>帳號</th>
    <th>電子信箱</th>
    <th>角色</th>
    <th>操作</th>
  </tr>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
    stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM members");

    while (rs.next()) {
        String userId = rs.getString("id");
        String email = rs.getString("email");
        String userRole = rs.getString("role");
%>
<tr>
  <td><%= userId %></td>
  <td><%= email %></td>
  <td><%= userRole %></td>
  <td>
    <% if (!"admin".equals(userRole)) { %>
      <a href="deleteMember.jsp?id=<%= userId %>" class="button" onclick="return confirm('確定要刪除 <%= userId %> 嗎？')">刪除</a>
    <% } else { %>
      管理員
    <% } %>
  </td>
</tr>
<%
    }
} catch (Exception e) {
    out.println("<tr><td colspan='4' style='color:red;'>錯誤：" + e.getMessage() + "</td></tr>");
} finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (stmt != null) try { stmt.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
}
%>
</table>
</body>
</html>
