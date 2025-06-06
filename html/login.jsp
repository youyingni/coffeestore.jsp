<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.security.*" %>
<%
String dbUrl = "jdbc:mysql://localhost:3306/coffee?useUnicode=true&characterEncoding=UTF-8";
String dbUser = "root";
String dbPwd = "1234";

String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
boolean triedLogin = false;
boolean loginSuccess = false;
String errorMsg = "";
String memberName = null;

if(session.getAttribute("memberID") != null) {
    loginSuccess = true;
    id = (String)session.getAttribute("memberID");
    memberName = id;
}

if(id != null && pwd != null && !loginSuccess) {
    triedLogin = true;
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
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
            session.setAttribute("memberID", id);
            session.setAttribute("memberName", id);
            String role = rs.getString("role");
            session.setAttribute("role", role);

            String redirectUrl = request.getParameter("redirect");
            if("admin".equals(role)) {
                response.sendRedirect("login1.jsp");
                return;
            } else if (redirectUrl != null && !redirectUrl.isEmpty()) {
                response.sendRedirect(redirectUrl);
                return;
            } else {
                response.sendRedirect("index.jsp");
                return;
            }
        } else {
            errorMsg = "\u5E33\u865F\u6216\u5BC6\u78BC\u932F\u8AA4\uff01\u8ACB\u91CD\u65B0\u8F38\u5165\u3002";
        }
    } catch(Exception e) {
        errorMsg = "\u7CFB\u7D71\u932F\u8AA4\uff1A" + e.getMessage();
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception e) {}
        if(ps != null) try { ps.close(); } catch(Exception e) {}
        if(conn != null) try { conn.close(); } catch(Exception e) {}
    }
}
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>會員中心登入</title>
  <link rel="stylesheet" href="../css/login.css">
  <link rel="stylesheet" href="../css/popup.css">
  <link rel="stylesheet" href="../css/coffee1.css">
  <link rel="stylesheet" href="../css/navBar.css">

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
    .register-link { color: #3377ff; text-decoration: underline; cursor: pointer; }
    .main-nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 30px;
      height: 70px;
      background-color: #513518;
      color: white;
    }
    .main-nav ul {
      list-style: none;
      display: flex;
      gap: 20px;
      padding: 0;
      margin: 0;
      align-items: center;
    }
    .main-nav a {
      text-decoration: none;
      color: white;
      font-weight: bold;
      padding: 10px;
    }
    .nav-right {
      display: flex;
      align-items: center;
      gap: 20px;
      font-size: 1.1em;
      color: #fff;
    }
    .logout-link {
      background: #b45a5a;
      color: #fff;
      border-radius: 4px;
      padding: 6px 12px;
      text-decoration: none;
      transition: background 0.3s;
    }
    .logout-link:hover {
      background: #a93226;
    }
  </style>
</head>
<body>
  <div class="wrapper">
    <nav class="main-nav">
      <ul>
        <li><a href="index.jsp"><img class="logo" src='../img/OIP.jpg'></a></li>
        <li><a href="personal.jsp">個人資料</a></li>
        <li><a href="history.jsp">歷史紀錄</a></li>
        <li><a href="class.html">課程介紹</a></li>
      </ul>
      <div class="nav-right">
        <% if(session.getAttribute("memberID")!=null) { %>
          <span><%= session.getAttribute("memberName") %> 歡迎登入</span>
          <a class="logout-link" href="logout.jsp">登出</a>
        <% } %>
      </div>
    </nav>
  </div>

  <section class="top-container">
    <header class="showcase">
      <div class="final">
        <h1>會員中心</h1>
        <p>咖啡和瑜珈課程</p>
      </div>
      <% if(!loginSuccess) { %>
      <div class="md-modal md-effect-13 <% if(triedLogin && !loginSuccess){ %>md-show<% } %>" id="modal-13">
        <div class="container md-content">
          <section class="form-section">
            <h2>會員帳號登入</h2>
            <form method="post" action="login.jsp">
              <div style="display: flex; flex-direction: column; align-items: center;">
                <label>帳號
                  <input type="text" name="id" placeholder="請輸入帳號" required value="<%= id!=null ? id : "" %>" style="margin-bottom: 10px; padding: 5px; width: 200px;" />
                </label>
                <label>密碼
                  <input type="password" name="pwd" placeholder="請輸入密碼" required style="margin-bottom: 10px; padding: 5px; width: 200px;" />
                </label>
                <input type="hidden" name="redirect" value="<%= request.getParameter("redirect") != null ? request.getParameter("redirect") : "" %>">
                <div style="display: flex; justify-content: space-between; align-items: center; width: 100%; gap: 10px;">
                  <button type="submit" class="btn" style="flex-grow: 1;">登入會員</button>
                  <a href="new.jsp" style="flex-grow: 1;"><button type="button" class="btn" style="width: 100%;">會員註冊</button></a>
                </div>
              </div>
            </form>
            <div id="messageArea">
              <% if(triedLogin && !loginSuccess) { %>
                <div style="color:red;"><%= errorMsg %></div>
                <a href="new.jsp" class="register-link">還沒註冊嗎？點此註冊會員</a>
              <% } %>
            </div>
          </section>
        </div>
      </div>
      <div class="md-overlay"></div>
      <button class="md-trigger btn" data-modal="modal-13">會員登入/註冊</button>
      <script src="../js/popup.js"></script>
      <% } %>
    </header>
  </section>

  <!-- Footer -->
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
                    <iconify-icon class="icon1" icon="formkit:instagram" width="50"
                        height="50"></iconify-icon>
                </a>
                <span>cominghsu</span>
                <iconify-icon class="icon1" icon="el:phone-alt" width="50"
                    height="50"></iconify-icon>
                <span>0911305010</span>
            </div>
            <div>
                <iconify-icon icon="maki:marker" style="color: #d22c0d" width="30"
                    height="30"></iconify-icon>
                地址：320桃園市中壢區環中東路357-1號
            </div>

        </div>
        <div class="right-section">
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3617.138166658024!2d121.25174567499147!3d24.961413377863547!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3468232a47f00ba3%3A0xa4ae5602976d050a!2z57ST5ZKWIOS_ruaBr-ajpw!5e0!3m2!1szh-TW!2stw!4v1733113194746!5m2!1szh-TW!2stw"
                allowfullscreen="" loading="lazy"
                referrerpolicy="no-referrer-when-downgrade">
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
            © 2020.紓咖修息棧 All Rights Reserved 網頁設計 ‧ CYCU IMFORMATUION
            MANAGEMENT&emsp;&emsp;&emsp;&emsp;&emsp;©
            2020.紓咖修息棧 All Rights Reserved 網頁設計 ‧ CYCU IMFORMATUION MANAGEMENT
        </div>
    </div>
</footer>
</body>
</html>
