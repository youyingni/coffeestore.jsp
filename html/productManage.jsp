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
  <title>商品管理</title>
  <link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap" rel="stylesheet">
  <style>
    body { font-family: "LXGW WenKai Mono TC", monospace; background-color: #f5f5f5; padding: 30px; }
    table { width: 100%; border-collapse: collapse; background-color: #fff; }
    th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
    th { background-color: #3a2a20; color: #fff; }
    h1 { text-align: center; }
    a.button { padding: 5px 10px; background-color: #57514d; color: white; text-decoration: none; border-radius: 4px; }
    a.button:hover { background-color: #2d3f54;color: #ffff00; }
    .title{font-size: 35px;}
  </style>
</head>
<body>
<h1 class="title">商品管理</h1>
<a href="login1.jsp" class="button">回上一頁</a>
<a href="addProduct.jsp" class="button">新增商品</a>
<br><br>

<table>
  <tr>
    <th>編號</th>
    <th>商品ID</th>
    <th>名稱</th>
    <th>類別</th>
    <th>連結</th>
    <th>圖片</th>
    <th>價格</th>
    <th>庫存</th>
    <th>操作</th>
  </tr>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
    stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM productss");

    while(rs.next()) {
%>
<tr>
  <td><%= rs.getInt("no") %></td>
  <td><%= rs.getString("id") %></td>
  <td><%= rs.getString("name") %></td>
  <td><%= rs.getString("category") %></td>
  <td><%= rs.getString("link") %></td>
  <td><img src="<%= rs.getString("image") %>" width="60"></td>
  <td><%= rs.getDouble("price") %></td>
  <td><%= rs.getInt("inventory") %></td>
  <td>
    <a href="editProduct.jsp?no=<%= rs.getInt("no") %>" class="button">編輯</a>
    <a href="deleteProduct.jsp?no=<%= rs.getInt("no") %>" class="button" onclick="return confirm('確定要刪除嗎？')">刪除</a>
  </td>
</tr>
<%
    }
} catch(Exception e) {
    out.print("<tr><td colspan='9'>錯誤：" + e.getMessage() + "</td></tr>");
} finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (stmt != null) try { stmt.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
}
%>
</table>
</body>
</html>
