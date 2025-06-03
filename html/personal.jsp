<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // 防止未登入訪問
    if(session.getAttribute("memberID")==null){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>個人資料中心</title>
    <script src="https://code.iconify.design/iconify-icon/2.1.0/iconify-icon.min.js"></script>
    <link rel="stylesheet" href="../css/personal.css">
    <link rel="stylesheet" href="../css/navBar.css">
    <link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap" rel="stylesheet">
</head>
<%
    // 連接資料庫，取得個人資料
    String dbUrl = "jdbc:mysql://localhost:3306/members?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root";
    String dbPwd = "1234";
    String id = (String)session.getAttribute("memberID"); // 使用登入時的 session key
    String email = "", phone = "", gender = "", birthday = "", address = "";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPwd);
        String sql = "SELECT * FROM members WHERE id=?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, id);
        rs = ps.executeQuery();
        if(rs.next()) {
            email = rs.getString("email");
            phone = rs.getString("phone");
            gender = rs.getString("gender");
            birthday = rs.getString("birthday");
            address = rs.getString("address");
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception e) {}
        if(ps != null) try { ps.close(); } catch(Exception e) {}
        if(conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>
<body>
    <div class="wrapper">
        <!-- Navigation -->
        <div class="main-nav">
            <ul>
                <li><a href="login.jsp">回上一頁</a></li>
            </ul>
        </div>
    </div>
    <div class="container">
        <!-- 基本個人資訊 -->
        <div class="section">
            <h2 onclick="toggleSection('section1')">基本個人資訊</h2>
            <div id="section1" class="section-content">
                <div class="profile">
                    <img src="../picture/customer.gif" alt="頭像">
                    <div class="details">
                        <p><strong>姓名：</strong><%= id %></p>
                        <p><strong>電子郵件：</strong><%= email %></p>
                        <p><strong>電話號碼：</strong><%= phone %></p>
                        <p><strong>性別：</strong><%= gender %></p>
                        <p><strong>生日：</strong><%= birthday %></p>
                        <p><strong>住家住址：</strong><%= address %></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- 地址與配送資訊 -->
        <div class="section">
            <h2 onclick="toggleSection('section2')">地址與配送資訊</h2>
            <div id="section2" class="section-content">
                <p><strong>常用地址：</strong><%= address %></p>
                
                <p><strong>配送備註：</strong> 請放置在門口</p>
            </div>
        </div>
        <!-- 安全性與隱私 -->
        <div class="section">
            <h2 onclick="toggleSection('section6')">安全性與隱私</h2>
            <div id="section6" class="section-content">
                <p><strong>密碼設定：</strong> 已更新</p>
                <p><strong>雙重驗證：</strong> 已啟用</p>
            </div>
        </div>
        <!-- 聯絡客服與反饋 -->
        <div class="section">
            <h2 onclick="toggleSection('section7')">聯絡客服與反饋</h2>
            <div id="section7" class="section-content">
                <p><strong>客服聯絡：</strong> <a href="mailto:support@example.com">support@example.com</a></p>
                <p><strong>常見問題：</strong> <a href="#">點此查看FAQ</a></p>
            </div>
        </div>
    </div>
    <script src="../js/personal.js"></script>
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
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3617.138166658024!2d121.25174567499147!3d24.961413377863547!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3468232a47f00ba3%3A0xa4ae5602976d050a!2z57ST5ZKWIOS_ruaBr-ajpw!5e0!3m2!1szh-TW!2stw!4v1733113194746!5m2!1szh-TW!2stw" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
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
