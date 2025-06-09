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

    if(session.getAttribute("memberID") != null && session.getAttribute("role") != null) {
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
                String role = rs.getString("role");
                session.setAttribute("memberID", id);
                session.setAttribute("memberName", id);
                session.setAttribute("role", role);
                memberName = id;
                response.sendRedirect("login.jsp");
                return;
            } else {
                errorMsg = "\u5E33\u865F\u6216\u5BC6\u78BC\u932F\u8AA4！\u8ACB\u91CD\u65B0\u8F38\u5165。";
            }
        } catch(Exception e) {
            errorMsg = "\u7CFB\u7D71\u932F\u8AA4：" + e.getMessage();
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
  <script src="https://code.iconify.design/iconify-icon/2.1.0/iconify-icon.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap" rel="stylesheet">
  <style>
    body { background-color: #DDCDC3; }
    .btn { padding: 10px 20px; font-size: 16px; border: none; border-radius: 5px; cursor: pointer; background-color: #4caf50; color: white; transition: background-color 0.3s; }
    .btn:hover { background-color: #45a049; }
    .main-nav { display: flex; justify-content: space-between; align-items: center; padding: 0 30px; height: 70px; background-color: #513518; color: white; }
    .main-nav ul { list-style: none; display: flex; gap: 20px; padding: 0; margin: 0; align-items: center; }
    .main-nav a { text-decoration: none; color: white; font-weight: bold; padding: 10px; }
    .nav-right { display: flex; align-items: center; gap: 20px; font-size: 1.1em; color: #fff; }
    .logout-link { background: #b45a5a; color: #fff; border-radius: 4px; padding: 6px 12px; text-decoration: none; transition: background 0.3s; }
    .logout-link:hover { background: #a93226; }
    .logo { border-radius: 100%; width: 35px; height: 35px; }
    .main-content {
  text-align: center;
  margin-top: 80px;
  padding: 40px;
  color: #333;
}

.main-content h1 {
  font-size: 32px;
  margin-bottom: 10px;
}

.main-content p {
  font-size: 18px;
  color: #666;
  margin-bottom: 30px;
}

.admin-actions {
  display: flex;
  justify-content: center;
  gap: 30px;
  flex-wrap: wrap;
}

.admin-btn {
  background-color: #273654;
  color: white;
  padding: 16px 30px;
  border-radius: 12px;
  text-decoration: none;
  font-size: 20px;
  transition: 0.3s;
}

.admin-btn:hover {
  background-color: #1c2b42;
  transform: scale(1.05);
}

  </style>
</head>
<body>
  <div class="wrapper">
    <nav class="main-nav">
      <ul>
        <li><a href="index.jsp"><img class="logo" src='../img/OIP.jpg'></a></li>
        <% String role = (String) session.getAttribute("role");
           if ("admin".equals(role)) { %>
            <li><a href="orderManage.jsp">訂單瀏覽</a></li>
            <li><a href="memberManage.jsp">會員管理</a></li>
            <li><a href="productManage.jsp">商品管理</a></li>
            <li><a href="commentManage.jsp">留言管理</a></li>
        <% } else if ("member".equals(role)) { %>
            <li><a href="personal.jsp">個人資料</a></li>
            <li><a href="history.jsp">歷史紀錄</a></li>
            <li><a href="class.html">課程介紹</a></li>
        <% } %>
      </ul>
      <div class="nav-right">
        <% if(session.getAttribute("memberID")!=null) { %>
          <span>
            <%= session.getAttribute("memberID") %>
            <%= "admin".equals(role) ? " 管理者" : " 會員" %>，歡迎登入！
          </span>
          <a class="logout-link" href="logout.jsp">登出</a>
        <% } %>
      </div>
    </nav>
  </div>
  <div class="main-content">
    <h1>管理員後台首頁</h1>
    <p>請選擇上方功能以管理網站資料。</p>
    <div class="admin-actions">
      <a href="orderManage.jsp" class="admin-btn">訂單瀏覽</a>
      <a href="memberManage.jsp" class="admin-btn">會員管理</a>
      <a href="productManage.jsp" class="admin-btn">商品管理</a>
      <a href="commentManage.jsp" class="admin-btn">留言管理</a>
    </div>
  </div>
  
</body>
</html>
