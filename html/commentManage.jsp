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
  <title>留言管理</title>
  
<link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap" rel="stylesheet">

  <style>
h2{
        width: 10%;
        font-family: "LXGW WenKai Mono TC", monospace;
        background-color:#424c6a ;
        text-align: center;
        border-radius: 25px;
        color: #eeff00;
        letter-spacing: 10px;
    }
    body { font-family: "LXGW WenKai Mono TC", monospace; background-color: #f5f5f5; padding: 30px; }
    table { width: 100%; border-collapse: collapse; background-color: #fff; }
    th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
    th { background-color: #3a2a20; color: #fff; }
    a.button {padding: 5px 10px; background-color: #57514d; color: white; text-decoration: none; border-radius: 4px; }
    a.button:hover { background-color: #2d3f54;color: #ffff00; }
  </style>
</head>
<body>
  <h2>留言管理</h2>
  <a href="login1.jsp" class="button">回上一頁</a>
  <br><br>
  <table>
    <tr>
      <th>ID</th>
      <th>姓名</th>
      <th>Email</th>
      <th>評分</th>
      <th>留言內容</th>
      <th>留言時間</th>
      <th>操作</th>
    </tr>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
    stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM comment ORDER BY date DESC");

    while (rs.next()) {
%>
    <tr>
      <td><%= rs.getInt("commentId") %></td>
      <td><%= rs.getString("commentName") %></td>
      <td><%= rs.getString("email") %></td>
      <td><%= rs.getInt("rate") %></td>
      <td><%= rs.getString("content") %></td>
      <td><%= rs.getString("date") %></td>
      <td>
        <a class="button" href="deleteComment.jsp?id=<%= rs.getInt("commentId") %>" onclick="return confirm('確定刪除此留言？');">刪除</a>
      </td>
    </tr>
<%
    }
} catch (Exception e) {
%>
    <tr><td colspan="7" style="color:red;">錯誤：<%= e.getMessage() %></td></tr>
<%
} finally {
    if (rs != null) try { rs.close(); } catch(Exception e) {}
    if (stmt != null) try { stmt.close(); } catch(Exception e) {}
    if (conn != null) try { conn.close(); } catch(Exception e) {}
}
%>
  </table>
</body>
</html>
