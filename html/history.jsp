<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%
request.setCharacterEncoding("UTF-8");
String customer = (String) session.getAttribute("memberID");
%>
<%
    // 判斷是否已登入，沒登入就導回登入頁
    if(session.getAttribute("memberID") == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>購物歷史紀錄</title>
    <link rel="stylesheet" href="../css/hitsory.css">
    <link rel="stylesheet" href="../css/navBar.css">
    <script src="https://code.iconify.design/iconify-icon/2.1.0/iconify-icon.min.js"></script>

    <link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap" rel="stylesheet">
</head>

<body>
    <div class="wrapper">
        <!-- Navigation -->
        <div class="main-nav">
            <ul>
                <li><a href="login.jsp">回上一頁</a></li>
            </ul>
        </div>
    </div>
    <div class="txt">
    <header><h1>我的購物紀錄</h1></header>
    <main>
     <% if (customer == null) { %>
  <p>請先登入會員以查看歷史紀錄。</p>
<% } else {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "500608");

        // ✅ 用登入帳號直接查 orders.customer_name
        String sql = "SELECT * FROM orders WHERE customer_name = ? ORDER BY order_time DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, customer);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            String orderID = rs.getString("id");
            String orderDate = rs.getString("order_time");
%>
<section class="order">
  <h2>訂單編號：<%= orderID %></h2>
  <p><strong>日期：</strong><%= orderDate %></p>
  <p><strong>狀態：</strong>已完成</p>

<%
  String itemSql = "SELECT oi.*, p.name AS product_name, p.image FROM order_items oi JOIN productss p ON oi.product_name = p.id WHERE oi.order_id = ?";
  PreparedStatement itemStmt = conn.prepareStatement(itemSql);
  itemStmt.setString(1, orderID);
  ResultSet itemRs = itemStmt.executeQuery();

  while (itemRs.next()) {
    String productName = itemRs.getString("product_name");  // ✅ 顯示中文商品名稱
    String image = itemRs.getString("image");
    int qty = itemRs.getInt("quantity");
    int price = itemRs.getInt("product_price");
%>
  <div class="order-details">
    <img src="<%= image %>" alt="商品圖片" width="100">
    <div class="product-info">
      <p><strong>商品名稱：</strong><%= productName %></p>
      <p><strong>數量：</strong><%= qty %></p>
      <p><strong>價格：</strong>NT$ <%= price %></p>
    </div>
  </div>
<%
  } itemRs.close(); itemStmt.close();
%>
</section>
<%
        } rs.close(); ps.close(); conn.close();
    } catch (Exception e) {
        out.println("資料庫錯誤：" + e.getMessage());
    }
} %>
    </main>

        <footer>

            <div class="footer-container">
                <div class="left-section">
                    <div class="social-icons">
                        <a href="https://www.facebook.com/relaxshuca">
                            <iconify-icon class="icon1" icon="entypo-social:facebook" width="50"
                                height="50"></iconify-icon>
                        </a>
                        <span>紓咖</span>
                        <a href="https://www.instagram.com/cominghsu_/?hl=zh-tw">
                            <iconify-icon class="icon1" icon="formkit:instagram" width="50" height="50"></iconify-icon>
                        </a>
                        <span>cominghsu</span>
                        <iconify-icon class="icon1" icon="el:phone-alt" width="50" height="50"></iconify-icon>
                        <span>0911305010</span>
                    </div>
                    <div>
                        <iconify-icon icon="maki:marker" style="color: #d22c0d" width="30" height="30"></iconify-icon>
                        地址：320桃園市中壢區環中東路357-1號
                    </div>

                </div>
                <div class="right-section">
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3617.138166658024!2d121.25174567499147!3d24.961413377863547!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3468232a47f00ba3%3A0xa4ae5602976d050a!2z57ST5ZKWIOS_ruaBr-ajpw!5e0!3m2!1szh-TW!2stw!4v1733113194746!5m2!1szh-TW!2stw"
                        allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                    <div>
                        <img src="../img/fb.png" alt="Facebook QR" width="100">
                        <p>facebook</p>
                    </div>
                    <div>
                        <img src="../img/ig.png" alt="Instagram QR" width="100">
                        <p>instagram</p>
                    </div>
                </div>
            </div>


            <div class="marquee">
                <div>
                    © 2020.紓咖修息棧 All Rights Reserved 網頁設計 ‧ CYCU IMFORMATUION MANAGEMENT&emsp;&emsp;&emsp;&emsp;&emsp;©
                    2020.紓咖修息棧 All Rights Reserved 網頁設計 ‧ CYCU IMFORMATUION MANAGEMENT
                </div>
            </div>
        </footer>
    </div>
</body>

</html>