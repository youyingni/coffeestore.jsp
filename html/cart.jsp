<!--購物車-->
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>購物車</title>
  <link
    href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap"
    rel="stylesheet">
  <style>
    /* 主體樣式 */
    body {
      text-align: center;
      margin: 20px;
    }

    /* 按鈕樣式 */
    button {
      padding: 10px 20px;
      font-size: 16px;
      margin-top: 20px;
      cursor: pointer;
      background-color: burlywood;
      color: aliceblue;
      font-weight: 600;
    }

    /* 模態框容器 */
    .modal {
      display: none;
      /* 預設隱藏 */
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 80%;
      max-width: 400px;
      background: white;
      box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
      border-radius: 10px;
      padding: 20px;
      z-index: 1000;
      font-weight: 800;
    }

    /* 模態框背景遮罩 */
    .overlay {
      display: none;
      /* 預設隱藏 */
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.5);
      z-index: 999;
    }

    /* SVG 勾勾樣式 */
    svg {
      display: block;
      margin: 0 auto;
      height: 80px;
      width: 80px;
      color: green;
      /* SVG path 使用 currentColor 繼承此顏色 */
    }

    .circle {
      stroke-dasharray: 76;
      stroke-dashoffset: 76;
      animation: draw 1s forwards;
    }

    .tick {
      stroke-dasharray: 18;
      stroke-dashoffset: 18;
      animation: draw 1s forwards 1s;
    }

    @keyframes draw {
      to {
        stroke-dashoffset: 0;
      }
    }

    .additional-buttons {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 20px;
      padding: 20px;
      border-radius: 8px;
    }

    .additional-buttons button {
      padding: 10px 20px;
      font-size: 16px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }


  </style>

  <style>
    @import url("../css/cart.css");
  </style>
</head>

<body>
<%
String memberID = (String) session.getAttribute("memberID");
if (memberID == null) {
%>
  <div style="background-color: #ffeeee; padding: 20px; border: 2px solid red; border-radius: 10px; margin: 30px;">
    <h2>⚠ 您尚未登入會員</h2>
    <p>請先<a href="login.jsp" style="color: blue; font-weight: bold;">登入會員</a>以查看購物車內容。</p>
  </div>
<%
} else {
%>


<!-- 不要再宣告 memberID -->
<%
try {
  Class.forName("com.mysql.jdbc.Driver");
  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
  PreparedStatement ps = conn.prepareStatement("SELECT cart.no, productss.name, productss.image, productss.price, cart.orderQ, cart.sugar, cart.ice FROM cart JOIN productss ON cart.id = productss.id WHERE cart.customerID = ?");
  ps.setString(1, memberID);
  ResultSet rs = ps.executeQuery();

  // 開始輸出 HTML 表格
%>
  <h1 class="page-title">購物車</h1>
  <form method="post" action="order.jsp" onsubmit="return prepareOrderData();">
  <div class="shopping-cart">
    <div class="column-labels">
      <label class="product-image">圖片</label>
      <label class="product-details">商品內容</label>
      <label class="product-price">價格</label>
      <label class="product-quantity">數量</label>
      <label class="product-line-price">總計</label>
      <label class="product-removal">移除</label>
    </div>
<%
  while (rs.next()) {
    int no = rs.getInt("no");
    String name = rs.getString("name");
    String image = rs.getString("image");
    int price = rs.getInt("price");
    int quantity = rs.getInt("orderQ");
    String sugar = rs.getString("sugar");
    String ice = rs.getString("ice");
    int total = price * quantity;
%>
    <div class="product" data-cartno="<%=no%>">
      <div class="product-image">
        <img src="<%=image%>">
      </div>
      <div class="product-details">
        <div class="product-title"><%=name%></div>
        <p class="product-description"><%=sugar%>/<%=ice%></p>
      </div>
      <div class="product-price"><%=price%></div>
      <div class="product-quantity">
        <input type="number" value="<%=quantity%>" min="1">
      </div>
      <div class="product-line-price"><%=total%></div>
      <div class="product-removal">
        <button type="button" class="remove-product" data-cartno="<%=no%>">
          <img src="../image/garbage.png" alt="" class="icon">
        </button>
      </div>
    </div>
<%
  }
  rs.close();
  ps.close();
  conn.close();
} catch (Exception e) {
  out.println("<p>錯誤: " + e.getMessage() + "</p>");
}
%>
<div class="order-remarks">
        <h2>客戶名字</h2>
        <textarea name="customer_name" placeholder="例如：請輸入名字" rows="3"></textarea>

        <h2>訂單備註</h2>
        <textarea name="remarks" placeholder="例如：請放在門口" rows="3"></textarea>
        <h2>收貨地址</h2>
        <textarea name="address" placeholder="例如：台北市信義區101號" rows="3"></textarea>
      </div>

<div class="payment-methods">
  <h2>付款方式</h2>
  <label>
    <input type="radio" name="payment" value="cod" checked>
    <div>
      <img src="../image/cash.png" alt="Line Pay">
      貨到付款
    </div>
  </label>
      
        
      <%
String member = (String) session.getAttribute("memberID");
boolean hasFreeShipping = false;
String couponCode = "";

if (member != null) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
        PreparedStatement ps = conn.prepareStatement("SELECT code FROM coupons WHERE customerID = ? AND isUsed = FALSE AND type = 'free_shipping'");
        ps.setString(1, member);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            hasFreeShipping = true;
            couponCode = rs.getString("code");
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p>查詢免運券錯誤：" + e.getMessage() + "</p>");
    }
}
%>

<% if (hasFreeShipping) { %>
    <div class="form-group">
        <button type="button" class="btn btn-success" onclick="applyCoupon('<%= couponCode %>')">
            使用免運券（折抵運費 NT$60）
        </button>
        <input type="hidden" name="discount" id="discountInput" value="">
        <div id="couponStatus" style="color: green; margin-top: 5px;"></div>
    </div>
<% } else { %>
    <div class="form-group text-muted">尚無可用的免運券</div>
<% } %>
      </div>
      <div class="totals">
        <div class="totals-item"><label>小計</label><div id="cart-subtotal">0.00</div></div>
        <div class="totals-item"><label>運費</label><div id="cart-shipping">60.00</div></div>
        <div class="totals-item"><label>總計</label><div id="cart-total">0.00</div></div>
      </div>
      <input type="hidden" name="subtotal" id="hidden-subtotal">
<input type="hidden" name="total" id="hidden-total">
<div class="button-container">
  <a href="Product_interface.jsp"><button type="button" class="return">繼續選購</button></a>
  <button class="checkout" type="submit">完成訂單</button>
      </div>
    </div>
  </form>
<% } %> <!-- 這是 if (memberID == null) 的 else 結尾 -->
<script>
let isDeleting = false;

function removeItem(removeButton) {
  if (!confirm("確定要移除這項商品嗎？")) return;

  const productRow = $(removeButton).closest('.product');
  const cartNo = $(removeButton).data("cartno");
  isDeleting = true;

  fetch("deleteCart.jsp", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `no=${cartNo}`
  }).then(res => {
    if (res.ok) {
      productRow.slideUp(fadeTime, function () {
        productRow.remove();
        recalculateCart();
        isDeleting = false;
      });
    } else {
      alert("刪除失敗");
      isDeleting = false;
    }
  });
}

function prepareOrderData() {
  if (isDeleting) {
    alert("請稍候，商品移除中...");
    return false;
  }
  document.getElementById("hidden-subtotal").value = document.getElementById("cart-subtotal").innerText;
  document.getElementById("hidden-total").value = document.getElementById("cart-total").innerText;
  return true;
}


const fadeTime = 300;
function recalculateCart() {
  let subtotal = 0;
  document.querySelectorAll(".product").forEach(function (product) {
    const price = parseFloat(product.querySelector(".product-price").innerText);
    const quantity = parseInt(product.querySelector(".product-quantity input").value);
    const linePrice = price * quantity;
    product.querySelector(".product-line-price").innerText = linePrice.toFixed(2);
    subtotal += linePrice;
  });
  const shipping = 60;
  document.getElementById("cart-subtotal").innerText = subtotal.toFixed(2);
  document.getElementById("cart-shipping").innerText = shipping.toFixed(2);
  document.getElementById("cart-total").innerText = (subtotal + shipping).toFixed(2);
}

document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll(".remove-product").forEach(function (btn) {
    btn.addEventListener("click", function () {
      removeItem(btn);
    });
  });
  document.querySelectorAll(".product-quantity input").forEach(function (input) {
    input.addEventListener("change", recalculateCart);
  });
  recalculateCart();
});

function applyCoupon(code) {
    document.getElementById('discountInput').value = code;
    document.getElementById('couponStatus').textContent = '已套用免運券（運費 $0）';

    // 修改運費顯示為 0
    document.getElementById("cart-shipping").innerText = "0.00";

    // 重新計算總計
    const subtotal = parseFloat(document.getElementById("cart-subtotal").innerText);
    const newTotal = subtotal + 0; // shipping = 0
    document.getElementById("cart-total").innerText = newTotal.toFixed(2);
}

</script>
    <script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src="../js/cart.js"></script>


</body>

</html>