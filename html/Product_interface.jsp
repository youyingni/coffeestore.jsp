<!--咖啡瀏覽介面-->
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>咖啡瀏覽介面</title>
  <script src="https://code.iconify.design/iconify-icon/2.1.0/iconify-icon.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.iconify.design/iconify-icon/2.1.0/iconify-icon.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@500&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Jura:wght@600&display=swap" rel="stylesheet">
  <link
    href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap"
    rel="stylesheet">

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css" />

  <style>
    @import url("../css/Product_interface.css");
    @import url("../css/navBar.css");

    .product-link {
      text-decoration: none;
      color: inherit;
      display: block;
      padding: 10px;
      background-color: transparent;
      transition: background-color 0.3s ease, color 0.3s ease;
      border-radius: 8px;
    }

    .product-link:hover {
      background-color: #bebebe;
      color: #ffffff;
    }
  </style>
</head>

<body>

  <%
  String role = (String) session.getAttribute("role");
  String memberLink = "login.jsp";
  if ("admin".equals(role)) {
      memberLink = "login1.jsp";
  }
%>

<nav id="primary_nav_wrap">
  <ul>
      <li><a href="index.jsp"><img class="logo" src='../img/OIP.jpg'></a></li>
      <li><a href="#">紓咖商品</a>
          <ul>
              <li>
                  <a href="Product_interface.jsp">紓咖咖啡</a>
              </li>
          </ul>
      </li>
      <li><a href="class.html">紓咖瑜珈</a>
          <ul>
              <li><a href="class.html#yoga10">初階課程</a></li>
              <li><a href="class.html#yoga20">進階課程</a></li>
          </ul>
      </li>
      <li><a href="act.html">紓咖活動</a>
          <ul>
              <li><a href="act.html#oil">精油</a></li>
              <li><a href="act.html#sounds">頌缽</a></li>
              <li><a href="act.html#words">書法</a></li>
              <li><a href="act.html#Xmas">聖誕</a></li>
          </ul>
      </li>
      <li><a href="storytelling.html">紓咖說書</a></li>
      <li><a href="aboutus.html">關於我們</a>
          <ul>
              <li><a href="aboutus.html#cats">店貓介紹</a></li>
              <li><a href="aboutus.html#qa">Q & A</a></li>
          </ul>
      </li>
      <li><a href="#">留言意見</a>
          <ul>
              <li><a href="comment.jsp">留言板</a></li>
              <li><a href="contact.html">意見箱</a></li>
          </ul>
      </li>
  </ul>
  <div class="icon">
      <ul>
          <li>
              <a href="<%= memberLink %>">
                  <iconify-icon icon="bi:people-circle" width="30px" height="30px"></iconify-icon>
              </a>
          </li>
          <li>
              <a href="cart.jsp">
                  <iconify-icon icon="guidance:shop" width="30px" height="30px"></iconify-icon>
              </a>
          </li>
      </ul>
  </div>
</nav>
  <header>

    <div>

      <div class="wrap">
  <div class="search">
    <input type="text" class="searchTerm" placeholder="想要喝什麼?">
    <button type="submit" class="searchButton">
      <iconify-icon icon="ic:baseline-search" width="40" height="36"></iconify-icon>
    </button>
  </div>
</div>
      <h1>店長推薦</h1>
    </div>

    <div class="carousels">
      <div class="card-container">
        <div class="card">
          <img class="card-img-top" src="../image/poc.png" alt="Tamilnadu" style="height: 200px;">
          <div class="card-body">
            <h4 class="card-title">Top3</h4>
            <p class="card-text">辦公室系列-小確辛</p>
            <a href="buy.jsp?product=office-blessing" class="btn btn-primary"
              style="font-family: 'LXGW WenKai Mono TC', monospace; color: white;">點我加購</a>
          </div>
        </div>
      </div>
      <div class="card-container">
        <div class="card">
          <img class="card-img-top" src="../image/coffee3.png" alt="Kerala" style="height: 200px;">
          <div class="card-body">
            <h4 class="card-title">TOP2</h4>
            <p class="card-text">髒髒咖啡</p>
            <a href="buy.jsp?product=dirty-coffee" class="btn btn-primary"
              style="font-family: 'LXGW WenKai Mono TC', monospace; color: white;">點我加購</a>
          </div>
        </div>
      </div>
      <div class="card-container">
        <div class="card">
          <img class="card-img-top" src="../image/milktea.png" alt="Mumbai" style="height: 200px;">
          <div class="card-body">
            <h4 class="card-title">TOP1</h4>
            <p class="card-text">薰衣草奶茶 (杯)</p>
            <a href="buy.jsp?product=lavender-milktea" class="btn btn-primary"
              style="font-family: 'LXGW WenKai Mono TC', monospace; color: white;">點我加購</a>
          </div>
        </div>
      </div>
      <button class="nav left" onclick="prevSlide()"><i class="bi bi-chevron-left"></i></button>
      <button class="nav right" onclick="nextSlide()"><i class="bi bi-chevron-right"></i></button>
    </div>
  </header>

  <section class="product-section">
    <h2>咖啡類</h2>
    <div class="product-grid">
<%
String url = "jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC";
String user = "root";
String password = "1234";

try {
    Connection conn = DriverManager.getConnection(url, user, password);
    String query = "SELECT * FROM productss WHERE category = '咖啡類'";
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(query);

    while (rs.next()) {
%>
      <!-- 6 個商品 -->
       <% while (rs.next()) { %>
  <div class="card" data-name="<%= rs.getString("name") %>">
    <img src="<%= rs.getString("image") %>" alt="商品圖片" class="card-img-top">
    <div class="card-body">
      <a href="buy.jsp?product=<%= rs.getString("id") %>" class="product-link">
        <h5 class="card-title"><%= rs.getString("name") %></h5>
        <p class="card-text">NT$<%= rs.getInt("price") %></p>
        <p class="card-text">庫存：<%= rs.getInt("inventory") %></p>
      </a>
    </div>
  </div>
<% } %>
<%
    }
    rs.close();
    stmt.close();
    conn.close();
} catch (SQLException e) {
    out.println("資料庫錯誤：" + e.getMessage());
}
%>
</div>

    </div>
  </section>

  <section class="product-section2">
    <h2>手沖咖啡</h2>
    <div class="product-grid">
      <!-- 6 個商品 -->
  <%
      try {
    Connection conn2 = DriverManager.getConnection(url, user, password);
    String query2 = "SELECT * FROM productss WHERE category = '手沖咖啡'";
    Statement stmt2 = conn2.createStatement();
    ResultSet rs2 = stmt2.executeQuery(query2);

    while (rs2.next()) {
%>
    <% while (rs2.next()) { %>
  <div class="card" data-name="<%= rs2.getString("name") %>">
    <img src="<%= rs2.getString("image") %>" alt="商品圖片" class="card-img-top">
    <div class="card-body">
      <a href="buy.jsp?product=<%= rs2.getString("id") %>" class="product-link">
        <h5 class="card-title"><%= rs2.getString("name") %></h5>
        <p class="card-text">NT$<%= rs2.getInt("price") %></p>
        <p class="card-text">庫存：<%= rs2.getInt("inventory") %></p>
      </a>
    </div>
  </div>
<% } %>
<%
    }
    rs2.close();
    stmt2.close();
    conn2.close();
} catch (SQLException e) {
    out.println("資料庫錯誤：" + e.getMessage());
}
%>
  </div>
  </section>


  <section class="product-section2">
    <h2>花草茶類</h2>
    <div class="product-grid">
      <!-- 8 個商品 -->
      <%
      try {
    Connection conn2 = DriverManager.getConnection(url, user, password);
    String query2 = "SELECT * FROM productss WHERE category = '花草茶類'";
    Statement stmt2 = conn2.createStatement();
    ResultSet rs2 = stmt2.executeQuery(query2);

    while (rs2.next()) {
%>
      <% while (rs2.next()) { %>
  <div class="card" data-name="<%= rs2.getString("name") %>">
    <img src="<%= rs2.getString("image") %>" alt="商品圖片" class="card-img-top">
    <div class="card-body">
      <a href="buy.jsp?product=<%= rs2.getString("id") %>" class="product-link">
        <h5 class="card-title"><%= rs2.getString("name") %></h5>
        <p class="card-text">NT$<%= rs2.getInt("price") %></p>
        <p class="card-text">庫存：<%= rs2.getInt("inventory") %></p>
      </a>
    </div>
  </div>
<% } %>

<%
    }
    rs2.close();
    stmt2.close();
    conn2.close();
} catch (SQLException e) {
    out.println("資料庫錯誤：" + e.getMessage());
}
%>
  </div>
  </section>


  <section class="product-section2">
    <h2>茶</h2>
    <div class="product-grid">

      <%
      try {
    Connection conn2 = DriverManager.getConnection(url, user, password);
    String query2 = "SELECT * FROM productss WHERE category = '茶類'";
    Statement stmt2 = conn2.createStatement();
    ResultSet rs2 = stmt2.executeQuery(query2);

    while (rs2.next()) {
%>
    <% while (rs2.next()) { %>
  <div class="card" data-name="<%= rs2.getString("name") %>">
    <img src="<%= rs2.getString("image") %>" alt="商品圖片" class="card-img-top">
    <div class="card-body">
      <a href="buy.jsp?product=<%= rs2.getString("id") %>" class="product-link">
        <h5 class="card-title"><%= rs2.getString("name") %></h5>
        <p class="card-text">NT$<%= rs2.getInt("price") %></p>
        <p class="card-text">庫存：<%= rs2.getInt("inventory") %></p>
      </a>
    </div>
  </div>
<% } %>
<%
    }
    rs2.close();
    stmt2.close();
    conn2.close();
} catch (SQLException e) {
    out.println("資料庫錯誤：" + e.getMessage());
}
%>
  </div>

  </section>


  <section class="product-section2">
    <h2>奶茶 / 可可</h2>
    <div class="product-grid">
      <!-- 6 個商品 -->
      <%
      try {
    Connection conn2 = DriverManager.getConnection(url, user, password);
    String query2 = "SELECT * FROM productss WHERE category = '奶茶 / 可可'";
    Statement stmt2 = conn2.createStatement();
    ResultSet rs2 = stmt2.executeQuery(query2);

    while (rs2.next()) {
%>
   <% while (rs2.next()) { %>
  <div class="card" data-name="<%= rs2.getString("name") %>">
    <img src="<%= rs2.getString("image") %>" alt="商品圖片" class="card-img-top">
    <div class="card-body">
      <a href="buy.jsp?product=<%= rs2.getString("id") %>" class="product-link">
        <h5 class="card-title"><%= rs2.getString("name") %></h5>
        <p class="card-text">NT$<%= rs2.getInt("price") %></p>
        <p class="card-text">庫存：<%= rs2.getInt("inventory") %></p>
      </a>
    </div>
  </div>
<% } %>
<%
    }
    rs2.close();
    stmt2.close();
    conn2.close();
} catch (SQLException e) {
    out.println("資料庫錯誤：" + e.getMessage());
}
%>
  </div>
  </section>


  <section class="product-section2">
    <h2>氣泡水</h2>
    <div class="product-grid">

      <%
      try {
    Connection conn2 = DriverManager.getConnection(url, user, password);
    String query2 = "SELECT * FROM productss WHERE category = '氣泡水'";
    Statement stmt2 = conn2.createStatement();
    ResultSet rs2 = stmt2.executeQuery(query2);

    while (rs2.next()) {
%>
  <% while (rs2.next()) { %>
  <div class="card" data-name="<%= rs2.getString("name") %>">
    <img src="<%= rs2.getString("image") %>" alt="商品圖片" class="card-img-top">
    <div class="card-body">
      <a href="buy.jsp?product=<%= rs2.getString("id") %>" class="product-link">
        <h5 class="card-title"><%= rs2.getString("name") %></h5>
        <p class="card-text">NT$<%= rs2.getInt("price") %></p>
        <p class="card-text">庫存：<%= rs2.getInt("inventory") %></p>
      </a>
    </div>
  </div>
<% } %>
<%
    }
    rs2.close();
    stmt2.close();
    conn2.close();
} catch (SQLException e) {
    out.println("資料庫錯誤：" + e.getMessage());
}
%>
  </div>
  </section>


  <section class="product-section2">
    <h2>功能性飲料- 發泡飲</h2>
    <div class="product-grid">

     <%
      try {
    Connection conn2 = DriverManager.getConnection(url, user, password);
    String query2 = "SELECT * FROM productss WHERE category = '功能性飲料- 發泡飲'";
    Statement stmt2 = conn2.createStatement();
    ResultSet rs2 = stmt2.executeQuery(query2);

    while (rs2.next()) {
%>
    <% while (rs2.next()) { %>
  <div class="card" data-name="<%= rs2.getString("name") %>">
    <img src="<%= rs2.getString("image") %>" alt="商品圖片" class="card-img-top">
    <div class="card-body">
      <a href="buy.jsp?product=<%= rs2.getString("id") %>" class="product-link">
        <h5 class="card-title"><%= rs2.getString("name") %></h5>
        <p class="card-text">NT$<%= rs2.getInt("price") %></p>
        <p class="card-text">庫存：<%= rs2.getInt("inventory") %></p>
      </a>
    </div>
  </div>
<% } %>
<%
    }
    rs2.close();
    stmt2.close();
    conn2.close();
} catch (SQLException e) {
    out.println("資料庫錯誤：" + e.getMessage());
}
%>
  </div>
  </section>


  <footer>

    <div class="footer-container">
      <div class="left-section">
        <div class="social-icons">
          <a href="https://www.facebook.com/relaxshuca">
            <iconify-icon class="icon1" icon="entypo-social:facebook" width="50" height="50"></iconify-icon>
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

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="../js/Product_interface.js"></script>
  <script>
document.querySelector('.searchButton').addEventListener('click', function () {
  const keyword = document.querySelector('.searchTerm').value.trim().toLowerCase();
  const cards = document.querySelectorAll('.card');
  if (keyword === '') {
    cards.forEach(card => card.style.display = 'block');
  } else {
    cards.forEach(card => {
      const name = card.getAttribute('data-name');
      if (name && name.toLowerCase().includes(keyword)) {
        card.style.display = 'block';
      } else {
        card.style.display = 'none';
      }
    });
  }
});
</script>
</body>



</html>