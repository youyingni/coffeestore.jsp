<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String no = request.getParameter("no");
String id="", name="", category="", link="", image="";
double price=0;
int inventory=0;

if (no != null && !"POST".equalsIgnoreCase(request.getMethod())) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM productss WHERE no=?");
        ps.setString(1, no);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            id = rs.getString("id");
            name = rs.getString("name");
            category = rs.getString("category");
            link = rs.getString("link");
            image = rs.getString("image");
            price = rs.getDouble("price");
            inventory = rs.getInt("inventory");
        }
        rs.close(); ps.close(); conn.close();
    } catch(Exception e) { out.print("錯誤：" + e.getMessage()); }
} else if ("POST".equalsIgnoreCase(request.getMethod())) {
    id = request.getParameter("id");
    name = request.getParameter("name");
    category = request.getParameter("category");
    link = request.getParameter("link");
    image = request.getParameter("image");
    price = Double.parseDouble(request.getParameter("price"));
    inventory = Integer.parseInt(request.getParameter("inventory"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
        PreparedStatement ps = conn.prepareStatement("UPDATE productss SET id=?, name=?, category=?, link=?, image=?, price=?, inventory=? WHERE no=?");
        ps.setString(1, id);
        ps.setString(2, name);
        ps.setString(3, category);
        ps.setString(4, link);
        ps.setString(5, image);
        ps.setDouble(6, price);
        ps.setInt(7, inventory);
        ps.setString(8, no);
        ps.executeUpdate();
        ps.close(); conn.close();
        response.sendRedirect("productManage.jsp");
        return;
    } catch(Exception e) { out.print("更新錯誤：" + e.getMessage()); }
}
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>編輯商品</title>
    <link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap" rel="stylesheet">
<style>
    from{
        font-family: "LXGW WenKai Mono TC", monospace;
    }  
   h2{
        width: 10%;
        font-family: "LXGW WenKai Mono TC", monospace;
        background-color:#57514d ;
        text-align: center;
        border-radius: 25px;
        color: #eeff00;
        letter-spacing: 10px;
    }
</style>
</head>
<body>      
<h2>編輯商品</h2>
<form method="post">
  ID: <input type="text" name="id" value="<%= id %>" required><br>
  名稱: <input type="text" name="name" value="<%= name %>" required><br>
  類別: <input type="text" name="category" value="<%= category %>" required><br>
  連結: <input type="text" name="link" value="<%= link %>"><br>
  圖片網址: <input type="text" name="image" value="<%= image %>"><br>
  價格: <input type="number" step="0.1" name="price" value="<%= price %>" required><br>
  庫存: <input type="number" name="inventory" value="<%= inventory %>" required><br>
  <input type="submit" value="更新">
</form>
</body>
</html>
