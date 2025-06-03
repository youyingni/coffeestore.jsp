<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.security.*" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>紓咖註冊</title>
    <link rel="stylesheet" href="../css/new.css">
    <link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap" rel="stylesheet">
    <style>
        body { background-color: #F3E7DE; }
        .main-nav { background-color: #513518; color: white; padding: 10px; }
        .main-nav a { color: white; text-decoration: none; }
        .register-container { background: #fff8f2; margin: 60px auto; padding: 32px 30px 24px 30px; max-width: 400px; border-radius: 20px; box-shadow: 0 6px 18px #b5a08240;}
        .form-group { margin-bottom: 20px; }
        label { display: block; font-size: 1rem; margin-bottom: 7px; }
        input { width: 100%; padding: 8px; border: 1px solid #c2b29b; border-radius: 5px;}
        .register-button { background: #4caf50; color: white; padding: 10px; border: none; width: 100%; border-radius: 5px; font-size: 1.1rem;}
        .register-button:hover { background: #45a049;}
        #errorMessage { margin-top: 16px; color: red; text-align: center;}
        .form-footer { margin-top: 20px; text-align: center; }
        .form-footer a { color: #3377ff; text-decoration: underline;}
    </style>
</head>
<body>
<%
    // 設定資料庫連線資訊
    String dbUrl = "jdbc:mysql://localhost:3306/members?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root"; // 請填你的MySQL帳號
    String dbPwd = "500608"; // 請填你的MySQL密碼

    String id = request.getParameter("id");
    String email = request.getParameter("email");
    String pwd = request.getParameter("pwd");
    String pwd2 = request.getParameter("pwd2");

    String errorMsg = "";
    boolean showError = false;

    if(id != null && email != null && pwd != null && pwd2 != null) {
        if(!pwd.equals(pwd2)) {
            errorMsg = "兩次密碼不一致，請重新輸入。";
            showError = true;
        } else {
            Connection conn = null;
            PreparedStatement checkId = null, checkEmail = null, insert = null;
            ResultSet rsId = null, rsEmail = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPwd);

                // 檢查帳號是否重複
                String checkIdSql = "SELECT * FROM members WHERE id=?";
                checkId = conn.prepareStatement(checkIdSql);
                checkId.setString(1, id);
                rsId = checkId.executeQuery();

                // 檢查 email 是否重複
                String checkEmailSql = "SELECT * FROM members WHERE email=?";
                checkEmail = conn.prepareStatement(checkEmailSql);
                checkEmail.setString(1, email);
                rsEmail = checkEmail.executeQuery();

                if(rsId.next()) {
                    errorMsg = "帳號已存在，請換一個帳號！";
                    showError = true;
                } else if(rsEmail.next()) {
                    errorMsg = "Email已註冊，請換一個Email！";
                    showError = true;
                } else {
                    // ------- 密碼進行 SHA-256 雜湊 -------
                    MessageDigest md = MessageDigest.getInstance("SHA-256");
                    md.update(pwd.getBytes("UTF-8"));
                    byte[] digest = md.digest();
                    StringBuilder sb = new StringBuilder();
                    for(byte b : digest) sb.append(String.format("%02x", b));
                    String hashedPwd = sb.toString();
                    // ------- 寫入資料庫 -------
                    String insertSql = "INSERT INTO members (id, pwd, email) VALUES (?,?,?)";
                    insert = conn.prepareStatement(insertSql);
                    insert.setString(1, id);
                    insert.setString(2, hashedPwd);
                    insert.setString(3, email);
                    int ok = insert.executeUpdate();
                    if(ok > 0){
                        response.sendRedirect("login.jsp");
                    } else {
                        errorMsg = "註冊失敗，請再試一次！";
                        showError = true;
                    }
                }
            } catch(Exception e) {
                errorMsg = "系統錯誤：" + e.getMessage();
                showError = true;
            } finally {
                if(rsId!=null) try{rsId.close();}catch(Exception e){}
                if(rsEmail!=null) try{rsEmail.close();}catch(Exception e){}
                if(checkId!=null) try{checkId.close();}catch(Exception e){}
                if(checkEmail!=null) try{checkEmail.close();}catch(Exception e){}
                if(insert!=null) try{insert.close();}catch(Exception e){}
                if(conn!=null) try{conn.close();}catch(Exception e){}
            }
        }
    }
%>
<div class="main-nav">
    <ul style="list-style:none;margin:0;padding:0;display:flex;gap:18px;">
        <li><a href="index.jsp">回到首頁</a></li>
    </ul>
</div>
<div class="register-container">
    <h2 style="text-align:center;margin-bottom:24px;">創立新帳號</h2>
    <form method="post" action="new.jsp" id="registerForm" autocomplete="off">
        <div class="form-group">
            <label for="id">帳號</label>
            <input type="text" id="id" name="id" placeholder="帳號 (請輸入英文或數字)" required maxlength="45"
                   value="<%= id!=null ? id : "" %>">
        </div>
        <div class="form-group">
            <label for="email">電子郵件</label>
            <input type="email" id="email" name="email" placeholder="Email" required maxlength="45"
                   value="<%= email!=null ? email : "" %>">
        </div>
        <div class="form-group">
            <label for="pwd">密碼</label>
            <input type="password" id="pwd" name="pwd" placeholder="密碼" required maxlength="45">
        </div>
        <div class="form-group">
            <label for="pwd2">確認密碼</label>
            <input type="password" id="pwd2" name="pwd2" placeholder="再次輸入密碼" required maxlength="45">
        </div>
        <button type="submit" class="register-button">確認送出</button>
    </form>
    <% if(showError) { %>
        <div id="errorMessage"><%= errorMsg %></div>
    <% } %>
    <div class="form-footer">
        <p>已經有帳號了？<a href="login.jsp">從這裡登入</a></p>
    </div>
</div>
</body>
</html>
