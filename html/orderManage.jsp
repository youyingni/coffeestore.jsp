<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
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
  <title>訂單管理</title>
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
    <h1 class="title">訂單瀏覽</h1>
    <a href="login1.jsp" class="button">回上一頁</a>
    <br>
    <br>
  <table>
    <tr>
      <th>ID</th>
      <th>顧客名稱</th>
      <th>地址</th>
      <th>備註</th>
      <th>付款方式</th>
      <th>優惠碼</th>
      <th>小計</th>
      <th>總金額</th>
      <th>下單時間</th>
    </tr>
    <%
      try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
          stmt = conn.createStatement();
          rs = stmt.executeQuery("SELECT * FROM orders ORDER BY order_time DESC");

          while (rs.next()) {
    %>
    <tr>
      <td><%= rs.getInt("id") %></td>
      <td><%= rs.getString("customer_name") %></td>
      <td><%= rs.getString("address") %></td>
      <td><%= rs.getString("remarks") %></td>
      <td><%= rs.getString("payment_method") %></td>
      <td><%= rs.getString("discount_code") %></td>
      <td><%= rs.getDouble("subtotal") %></td>
      <td><%= rs.getDouble("total") %></td>
      <td><%= rs.getString("order_time") %></td>
    </tr>
    <%
          }
      } catch (Exception e) {
    %>
    <tr><td colspan="9" style="color:red;">讀取資料失敗：<%= e.getMessage() %></td></tr>
    <%
      } finally {
          if (rs != null) try { rs.close(); } catch (Exception e) {}
          if (stmt != null) try { stmt.close(); } catch (Exception e) {}
          if (conn != null) try { conn.close(); } catch (Exception e) {}
      }
    %>
  </table>
</body>
</html>
