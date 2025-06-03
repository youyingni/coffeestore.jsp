<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="zh-Hant">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>咖啡購買介面</title>
  <link rel="stylesheet" href="../css/style.css">
  <link
    href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap"
    rel="stylesheet">


  <style>
    .card-title-link {
      text-decoration: none;
      color: inherit;
    }

    .card-title-link:hover h5 {
      text-decoration: underline;
    }

    .logo {
      border-radius: 100%;
      width: 35px;
      height: 35px;
      margin-left: 20px;
    }

    .description {
      background-color: rgb(125, 159, 159);
      color: white;
      font-weight: 400;
      border-radius: 10px;
    }

    a {
      margin-left: 15px;
      color: aliceblue;
    }
  </style>

</head>
<script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>
<%
String id = request.getParameter("product");
String name = "";
String image = "";
int price = 0;
int inventory = 0;

if (id != null && !"".equals(id)) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "500608");
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM productss WHERE id = ?");
        stmt.setString(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            image = rs.getString("image");
            price = rs.getInt("price");
            inventory = rs.getInt("inventory");
        } else {
            out.println("<p>找不到商品資料。</p>");
        }
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p>資料庫錯誤：" + e.getMessage() + "</p>");
    }
} else {
    out.println("<p>未指定商品 ID。</p>");
}
%>
<body>
  
   <%
request.setCharacterEncoding("UTF-8");
String action = request.getParameter("action");
String productId = request.getParameter("product");

if ("add".equals(action)) {
    String customerID = (String) session.getAttribute("memberID");
    if (customerID == null) {
        out.print("NOT_LOGIN");
        return;
    }

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "500608");

        String sugar = request.getParameter("sugar");
        String ice = request.getParameter("ice");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        String sql = "INSERT INTO cart (id, sugar, ice, customerID, orderQ) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, productId);
        ps.setString(2, sugar);
        ps.setString(3, ice);
        ps.setString(4, customerID);
        ps.setInt(5, quantity);
        ps.executeUpdate();
        ps.close();
        conn.close();

        out.print("OK");
        return;
    } catch (Exception e) {
        out.print("ERROR: " + e.getMessage());
        return;
    }
}
%>
  <nav class="navbar">
    <div class="aa">
      <div>
        <a href="../html/index.jsp"><img class="logo" src='../img/OIP.jpg'></a>
      </div>
      <div class="navbar-icons">
        
      <a href="login.jsp"><img src="../image/member.png" alt="member" class="icons mx-2"></a>


        <!-- cart特效 -->
        <a href="cart.jsp" class="cart-link">
          <div id="cart" class="cart" data-totalitems="0">
            <img src="../image/cart.png" alt="cart" class="icons mx-2">
          </div>
        </a>
      </div>
    </div>
  </nav>


  <main class="container">
  <section class="product">
    <div class="product-image-container">
      <img src="<%= image %>" alt="商品圖片" class="product-image">
      <h1><%= name %></h1>
      <p>NT$<%= price %></p>
      <div class="description">
        <h4>剩餘庫存：<%= inventory %> 件</h4>
      </div>
    </div>

      <!-- 選項 -->
      <div class="product-details">
        <div class="options">
          <p>選擇甜度</p>
          <div class="sweetness">
            <button data-group="sweetness">半糖</button>
            <button data-group="sweetness">微糖</button>
            <button data-group="sweetness">無糖</button>
          </div>
          <p>選擇冰塊</p>
          <div class="ice">
            <button data-group="ice">冰的</button>
            <button data-group="ice">少冰</button>
            <button data-group="ice">去冰</button>
            <button data-group="ice">溫的</button>
            <button data-group="ice">熱的</button>
          </div>
        </div>

        <div class="d-flex align-items-center">
          <span class="me-2">數量</span>
          <button class="btn btn-outline-secondary" id="decrease-btn"
            style="background-color: grey;border-radius: 10px;">-</button>
          <input type="number" id="quantity-input" class="mx-2" value="1" min="1"
            style="width: 80px; text-align: center;">
          <button class="btn btn-outline-secondary" id="increase-btn"
            style="background-color: grey;border-radius: 10px;">+</button>
        </div>
        <!-- cart特效 -->
        <div class="button-container">
          <div class="page-wrapper">
            <button id="addtocart">
              加入購物車
              <span class="cart-item"></span>
            </button>
          </div>


          
        </div>
    </section>


    <section class="related-products">
  <h2>推薦相關商品</h2>
  <div class="product-grid">
    <%
      try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "500608");

        // 隨機選三筆不同於目前商品的資料
        String sql = "SELECT * FROM productss WHERE id != ? ORDER BY RAND() LIMIT 3";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, productId);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
          String rName = rs.getString("name");
          String rImage = rs.getString("image");
          int rPrice = rs.getInt("price");
          int rInventory = rs.getInt("inventory");
          String rId = rs.getString("id");
    %>
    <div class="card">
      <img src="<%= rImage %>" alt="<%= rName %>" class="card-img-top">
      <a href="buy.jsp?product=<%= rId %>" style="text-decoration: none; color: inherit;">
        <div class="card-body">
          <h5 class="card-title"><%= rName %></h5>
          <p class="card-text">NT$<%= rPrice %></p>
          <div class="description">
            <p>庫存剩餘：<%= rInventory %> 件</p>
          </div>
        </div>
      </a>
    </div>
    <%
        }
        rs.close();
        stmt.close();
        conn.close();
      } catch (Exception e) {
        out.println("<p>推薦商品載入錯誤：" + e.getMessage() + "</p>");
      }
    %>
  </div>
</section>
  </main>


  <script>
    /*按鈕邏輯*/


    document.addEventListener("DOMContentLoaded", () => {
      const decreaseBtn = document.getElementById("decrease-btn");
      const increaseBtn = document.getElementById("increase-btn");
      const quantityInput = document.getElementById("quantity-input");

      // 增加數量
      increaseBtn.addEventListener("click", () => {
        const currentValue = parseInt(quantityInput.value, 10) || 0;
        quantityInput.value = currentValue + 1;
      });

      // 減少數量
      decreaseBtn.addEventListener("click", () => {
        const currentValue = parseInt(quantityInput.value, 10) || 1;
        if (currentValue > 1) {
          quantityInput.value = currentValue - 1;
        }
      });
    });








  document.addEventListener("DOMContentLoaded", function () {
  const addToCartButton = document.getElementById("addtocart");

  addToCartButton.addEventListener("click", function () {
    const sweetness = document.querySelector("button[data-group='sweetness'].selected");
    const ice = document.querySelector("button[data-group='ice'].selected");
    const quantity = document.getElementById("quantity-input").value;
    const product = new URLSearchParams(window.location.search).get("product");

    if (!sweetness || !ice) {
      alert("請先選擇甜度和冰塊");
      return;
    }

    const data = new URLSearchParams();
    data.append("action", "add");
    data.append("product", product);
    data.append("sugar", sweetness.innerText);
    data.append("ice", ice.innerText);
    data.append("quantity", quantity);

    fetch("buy.jsp", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data.toString()
    }).then(response => response.text())
      .then(result => {
        if (result === "NOT_LOGIN") {
          alert("請先登入");
          window.location.href = "login.jsp";
        } else if (result === "OK") {
          alert("成功加入購物車！");
        } else {
          alert("加入購物車失敗：" + result);
        }
      });
  });
});




  </script>

  <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script>
  <script src="../js/script.js"></script>
</body>

</html>