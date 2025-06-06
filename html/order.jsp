<!--訂單詳情-->
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂單</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css">
    <link
        href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap"
        rel="stylesheet">
    <style>
        body {
            font-family: "LXGW WenKai Mono TC", monospace;
            background-color: #DDCDC3;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .order-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 600px;
        }

        .order-header {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color: #333;
            font-family: "LXGW WenKai Mono TC", monospace;
        }

        .product-header,
        .product {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 10px 0;

        }

        .product-header {
            font-weight: bold;
            border-bottom: 2px solid #aaa;
            font-size: 16px;
        }

        .product-image img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
        }

        .product-details {
            flex: 2;
            margin-left: 15px;

        }

        .product-title {
            font-weight: bold;
            font-size: 16px;
        }

        .product-description {
            font-size: 14px;
            color: #777;
        }

        .product-price,
        .product-quantity,
        .product-line-price {
            flex: 1;
            text-align: center;
            font-size: 16px;
        }

        .total-section {
            text-align: right;
            margin-right: 30px;
            margin-top: 20px;
            font-size: 18px;
            font-weight: bold;
        }

        .total-section span {
            color: #d9534f;
        }

        button {
            margin: 20px auto;
            display: block;
            width: 200px;
            height: 40px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .progress-bar {
            background-color: rgb(91, 173, 8);
        }

        @media (max-width: 768px) {
            .order-container {
                padding: 15px;
                max-width: 400px;
            }

        }
    </style>
</head>

<body>


<%
request.setCharacterEncoding("UTF-8");
String customer = (String) session.getAttribute("memberID");
String address = request.getParameter("address");
String remarks = request.getParameter("remarks");
String payment = request.getParameter("payment");
String discountCode = request.getParameter("discount");
String subtotalStr = request.getParameter("subtotal");
BigDecimal subtotal = new BigDecimal(subtotalStr);
BigDecimal total = BigDecimal.ZERO;
int orderId = 0;

if (customer == null) {
    out.println("<p>請先登入才能建立訂單。</p>");
    return;
}

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");

    int shippingFee = 60;
    if (discountCode != null && !discountCode.isEmpty()) {
        PreparedStatement checkCoupon = conn.prepareStatement("SELECT * FROM coupons WHERE code = ? AND isUsed = FALSE");
        checkCoupon.setString(1, discountCode);
        ResultSet checkRs = checkCoupon.executeQuery();
        if (checkRs.next() && "free_shipping".equals(checkRs.getString("type"))) {
            shippingFee = 0;
            PreparedStatement markUsed = conn.prepareStatement("UPDATE coupons SET isUsed = TRUE WHERE code = ?");
            markUsed.setString(1, discountCode);
            markUsed.executeUpdate();
            markUsed.close();
        }
        checkRs.close();
        checkCoupon.close();
    }

    // ⛳ 修正重點：此處不能重新宣告 total，直接賦值即可
    total = subtotal.add(new BigDecimal(shippingFee));

    String insertOrder = "INSERT INTO orders (customer_name, address, remarks, payment_method, discount_code, subtotal, total) VALUES (?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement ps = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);
    ps.setString(1, customer);
    ps.setString(2, address);
    ps.setString(3, remarks);
    ps.setString(4, payment);
    ps.setString(5, discountCode);
    ps.setBigDecimal(6, subtotal);
    ps.setBigDecimal(7, total);
    ps.executeUpdate();

    ResultSet generatedKeys = ps.getGeneratedKeys();
    if (generatedKeys.next()) {
        orderId = generatedKeys.getInt(1);
    }

    PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM orders WHERE customer_name = ?");
    countStmt.setString(1, customer);
    ResultSet countRs = countStmt.executeQuery();
    int orderCount = 0;
    if (countRs.next()) {
        orderCount = countRs.getInt(1);
    }
    countRs.close();
    countStmt.close();

    if (orderCount == 1 || orderCount == 3 || orderCount == 5 || orderCount == 7) {
        String couponCode = "FREE" + System.currentTimeMillis();
        PreparedStatement couponStmt = conn.prepareStatement("INSERT INTO coupons (code, customerID, type) VALUES (?, ?, 'free_shipping')");
        couponStmt.setString(1, couponCode);
        couponStmt.setString(2, customer);
        couponStmt.executeUpdate();
        couponStmt.close();
    }

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT cart.*, productss.id, productss.price FROM cart JOIN productss ON cart.id = productss.id");

    PreparedStatement itemPs = conn.prepareStatement("INSERT INTO order_items (order_id, product_name, product_price, quantity, sugar, ice) VALUES (?, ?, ?, ?, ?, ?)");
    PreparedStatement updateStock = conn.prepareStatement("UPDATE productss SET inventory = inventory - ? WHERE id = ?");

    while (rs.next()) {
        itemPs.setInt(1, orderId);
        itemPs.setString(2, rs.getString("id"));
        itemPs.setBigDecimal(3, rs.getBigDecimal("price"));
        itemPs.setInt(4, rs.getInt("orderQ"));
        itemPs.setString(5, rs.getString("sugar"));
        itemPs.setString(6, rs.getString("ice"));
        itemPs.executeUpdate();

        updateStock.setInt(1, rs.getInt("orderQ"));
        updateStock.setString(2, rs.getString("id"));
        updateStock.executeUpdate();
    }

    stmt.executeUpdate("DELETE FROM cart WHERE customerID = '" + customer + "'");
    rs.close();
    stmt.close();
    ps.close();
    itemPs.close();
    updateStock.close();
    conn.close();
} catch (Exception e) {
    out.println("<p>資料庫錯誤: " + e.getMessage() + "</p>");
}
%>
<div class="order-container">
    <div class="order-header">訂單完成！</div>
    <div class="progress" style="height: 20px; margin: 20px 0;">
        <div class="progress-bar progress-bar-striped progress-bar-animated" style="width: 100%;"></div>
    </div>
    <div class="text-center" style="color: #777;">感謝您的訂購！</div>
    <div class="details">
        <p>名字：<%= customer %></p>
        <p>訂單編號：<%= orderId %></p>
        <p>付款方式：<%= payment %></p>
        <p>收貨地址：<%= address %></p>
        <p>訂單總金額：<span>$<%= total %></span></p>
        <h5 style="font-weight: bold; margin-top: 20px;">訂單資訊</h5>
        <div class="product-header">
            <div style="flex: 2;">品項</div>
            <div style="flex: 1; text-align: center;">單價</div>
            <div style="flex: 1; text-align: center;">數量</div>
            <div style="flex: 1; text-align: center;">金額</div>
        </div>
<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");
    PreparedStatement stmt2 = conn2.prepareStatement("SELECT oi.*, p.name AS product_display_name FROM order_items oi JOIN productss p ON oi.product_name = p.id WHERE oi.order_id = ?");
    stmt2.setInt(1, orderId);
    ResultSet rs2 = stmt2.executeQuery();
    while (rs2.next()) {
        String productName = rs2.getString("product_display_name");
        int price = rs2.getInt("product_price");
        int quantity = rs2.getInt("quantity");
        int lineTotal = price * quantity;
%>
        <div class="product">
            <div style="flex: 2;"><%= productName %></div>
            <div class="product-price">$<%= price %></div>
            <div class="product-quantity"><%= quantity %></div>
            <div class="product-line-price">$<%= lineTotal %></div>
        </div>
<%
    }
    rs2.close();
    stmt2.close();
    conn2.close();
} catch (Exception e) {
    out.println("<p>查詢商品名稱錯誤：" + e.getMessage() + "</p>");
}
%>

        <a href="index.jsp"><button>回首頁</button></a>
    </div>
</div>
    <script>
        function generateOrderNumber() {
            return 'ORD' + Math.random().toString(36).substr(2, 10).toUpperCase();
        }

        function getCurrentDateTime() {
            const now = new Date();
            return now.toISOString().slice(0, 16).replace('T', ' ');
        }

        function getEstimatedDeliveryDate() {
            const now = new Date();
            now.setDate(now.getDate() + 3);
            return now.toISOString().slice(0, 10);
        }

        document.getElementById('orderNumber').textContent = generateOrderNumber();
        document.getElementById('orderDate').textContent = getCurrentDateTime();
        document.getElementById('estimatedDate').textContent = getEstimatedDeliveryDate();


    </script>

</body>

</html>