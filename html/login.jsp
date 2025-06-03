<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.security.*" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>會員中心登入</title>
  <link rel="stylesheet" href="../css/login.css">
  <link rel="stylesheet" href="../css/popup.css">
  <link rel="stylesheet" href="../css/coffee1.css">
  <script src="https://code.iconify.design/iconify-icon/2.1.0/iconify-icon.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap" rel="stylesheet">
  <style>
    body { background-color: #DDCDC3; }
    .btn {
      padding: 10px 20px;
      font-size: 16px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      background-color: #4caf50;
      color: white;
      transition: background-color 0.3s;
    }
    .btn:hover { background-color: #45a049; }
    #messageArea { margin-top: 20px; text-align: center; font-weight: bold; }
    .main-nav { background-color: #513518; color: white; }
    .main-nav a { background-color: #513518; color: white; }
    .register-link { color: #3377ff; text-decoration: underline; cursor: pointer; }
  </style>
</head>
<body>
  <div class="wrapper">
    <nav class="main-nav">
      <ul>
        <li><a href="index.jsp"><img class="logo" src='../img/OIP.jpg'>回首頁</a></li>
        <li><a href="personal.html">個人資料</a></li>
        <li><a href="history.jsp">歷史紀錄</a></li>
        <li><a href="class.html">課程介紹</a></li>
      </ul>
    </nav>
  </div>
  <section class="top-container">
    <header class="showcase">
      <div class="final">
        <h1>會員中心</h1>
        <p>咖啡和瑜珈課程</p>
      </div>
<%
    String dbUrl = "jdbc:mysql://localhost:3306/members?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root"; // 請換成你的MySQL帳號
    String dbPwd = "500608"; // 請換成你的MySQL密碼

    String id = request.getParameter("id");
    String pwd = request.getParameter("pwd");
    boolean triedLogin = false;
    boolean loginSuccess = false;
    String errorMsg = "";

    if(id != null && pwd != null) {
        triedLogin = true;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            // 密碼雜湊
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(pwd.getBytes("UTF-8"));
            byte[] digest = md.digest();
            StringBuilder sb = new StringBuilder();
            for(byte b : digest) sb.append(String.format("%02x", b));
            String hashedPwd = sb.toString();

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPwd);
            String sql = "SELECT * FROM members WHERE id=? AND pwd=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, hashedPwd);
            rs = ps.executeQuery();
            if(rs.next()) {
                loginSuccess = true;
                session.setAttribute("memberID", id); // 登入帳號
                session.setAttribute("memberName", rs.getString("name"));
            } else {
                errorMsg = "帳號或密碼錯誤！請重新輸入。";
            }
        } catch(Exception e) {
            errorMsg = "系統錯誤：" + e.getMessage();
        } finally {
            if(rs != null) try { rs.close(); } catch(Exception e) {}
            if(ps != null) try { ps.close(); } catch(Exception e) {}
            if(conn != null) try { conn.close(); } catch(Exception e) {}
        }
    }
%>
      <!-- 彈窗DIV：登入錯誤自動加 md-show（popup.js 控制彈窗） -->
      <div class="md-modal md-effect-13 <% if(triedLogin && !loginSuccess){ %>md-show<% } %>" id="modal-13">
        <div class="container md-content">
          <section class="form-section">
            <h2>會員帳號登入</h2>
            <form method="post" action="login.jsp">
              <div style="display: flex; flex-direction: column; align-items: center;">
                <label>
                  帳號
                  <input type="text" name="id" placeholder="請輸入帳號" style="margin-bottom: 10px; padding: 5px; width: 200px;" required value="<%= id!=null ? id : "" %>" />
                </label>
                <label>
                  密碼
                  <input type="password" name="pwd" placeholder="請輸入密碼" style="margin-bottom: 10px; padding: 5px; width: 200px;" required />
                </label>
                <div style="display: flex; justify-content: space-between; align-items: center; width: 100%; gap: 10px;">
                  <button type="submit" class="btn" style="flex-grow: 1;">登入會員</button>
                  <a href="new.jsp" style="flex-grow: 1;">
                    <button type="button" class="btn" style="width: 100%;">會員註冊</button>
                  </a>
                </div>
              </div>
            </form>
            <div id="messageArea">
              <% if(triedLogin && !loginSuccess) { %>
                <div style="color:red;"><%= errorMsg %></div>
                <a href="new.jsp" class="register-link">還沒註冊嗎？點此註冊會員</a>
              <% } else if(triedLogin && loginSuccess) { %>
                <span style="color:green;">登入成功！歡迎 <%= id %>！</span>
                <br>
                <a href="Login_successful.html" id="memberLink">回到會員</a>
                <a href="index.html" id="homeLink">回到首頁</a>
              <% } %>
            </div>
          </section>
        </div>
      </div>
      <div class="md-overlay"></div>
      <button class="md-trigger btn" data-modal="modal-13">會員登入/註冊</button>
      <script src="../js/popup.js"></script>
    </header>
    <!-- 熱賣課程 -->
    <div class="hot-sale-carousel">
      <div class="hot-sale-card active">
        <div class="product-image">
          <img src="../picture/shka1.jpg" alt="商品1">
        </div>
        <h3 class="hotclass">熱賣課程：瑜伽入門</h3>
        <p class="sale-price">特價：$299</p>
        <p class="original-price">原價：$399</p>
        <a href="Yoga_interface.html"><button class="buy-button">立即購買</button></a>
      </div>
      <div class="hot-sale-card">
        <div class="product-image">
          <img src="../picture/shka2.jpg" alt="商品2">
        </div>
        <h3 class="hotclass">熱賣課程：靈性瑜珈</h3>
        <p class="sale-price">特價：$149</p>
        <p class="original-price">原價：$249</p>
        <a href="Yoga_interface.html"><button class="buy-button">立即購買</button></a>
      </div>
      <div class="hot-sale-card">
        <div class="product-image">
          <img src="../picture/shka3.jpg" alt="商品3">
        </div>
        <h3 class="hotclass">熱賣課程：經絡瑜珈</h3>
        <p class="sale-price">特價：$79</p>
        <p class="original-price">原價：$159</p>
        <a href="Yoga_interface.html"><button class="buy-button">立即購買</button></a>
      </div>
    </div>
    <div class="carousel-indicators">
      <button data-slide="0" class="active"></button>
      <button data-slide="1"></button>
      <button data-slide="2"></button>
      <script src="../js/ad.js"></script>
    </div>
  </section>
  <!-- Footer -->
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
</body>
</html>
