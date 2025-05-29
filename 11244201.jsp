<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
<head><title>訪客計數器</title></head>
<body>

<%
int counter = 0;
String strNo = "";

// 檢查 Application 層的計數器
if (application.getAttribute("counter") == null) {
    counter = 1000; // 設定初始值
    application.setAttribute("counter", String.valueOf(counter));
} else {
    strNo = (String) application.getAttribute("counter"); 
    counter = Integer.parseInt(strNo);
}

// **確保 Session 只在新的訪客時才影響計數**
if (session.isNew()) {
    counter++;        
    application.setAttribute("counter", String.valueOf(counter));
}
%>

<h3>您是第 <%= counter %> 位貴客！</h3>

</body>
</html>
