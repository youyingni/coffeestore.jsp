<%@ page import="java.sql.*" %>
<%
  request.setCharacterEncoding("UTF-8");
  String no = request.getParameter("no");
  String memberID = (String) session.getAttribute("memberID");

  if (no == null || memberID == null) {
    out.print("error: 缺少 no 或未登入。no=" + no + ", memberID=" + memberID);
    return;
  }

  Connection conn = null;
  PreparedStatement ps = null;

  try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/coffee?serverTimezone=UTC", "root", "1234");

    ps = conn.prepareStatement("DELETE FROM cart WHERE no = ? AND customerID = ?");
    ps.setInt(1, Integer.parseInt(no));
    ps.setString(2, memberID);
    int row = ps.executeUpdate();

    if (row > 0) {
      out.print("success");
    } else {
      out.print("fail: no=" + no + ", memberID=" + memberID + " 無法對應到資料");
    }
  } catch (Exception e) {
    out.print("error: " + e.getMessage());
  } finally {
    if (ps != null) try { ps.close(); } catch (Exception ignore) {}
    if (conn != null) try { conn.close(); } catch (Exception ignore) {}
  }
%>
