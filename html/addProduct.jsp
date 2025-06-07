<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String category = request.getParameter("category");
    String link = request.getParameter("link");
    String image = request.getParameter("image");
    double price = Double.parseDouble(request.getParameter("price"));
    int inventory = Integer.parseInt(request.getParameter("inventory"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
        String sql = "INSERT INTO productss(id, name, category, link, image, price, inventory) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, id);
        ps.setString(2, name);
        ps.setString(3, category);
        ps.setString(4, link);
        ps.setString(5, image);
        ps.setDouble(6, price);
        ps.setInt(7, inventory);
        ps.executeUpdate();
        ps.close();
        conn.close();
        response.sendRedirect("productManage.jsp");
        return;
    } catch (Exception e) {
        out.println("錯誤：" + e.getMessage());
    }
}
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>新增商品</title>
<link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap" rel="stylesheet">
<style>
    from{
        font-family: "LXGW WenKai Mono TC", monospace;
    }  
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
<h2>新增商品</h2>
<a href="productManage.jsp" class="button">回上一頁</a>
<br>
<br>
<form method="post">
  ID: <input type="text" name="id" required><br>
  名稱: <input type="text" name="name" required><br>
  類別: <input type="text" name="category" required><br>
  連結: <input type="text" name="link"><br>
  圖片網址: <input type="text" name="image"><br>
  價格: <input type="number" step="0.1" name="price" required><br>
  庫存: <input type="number" name="inventory" required><br>
  <input type="submit" value="新增">
</form>
</body>
</html>
