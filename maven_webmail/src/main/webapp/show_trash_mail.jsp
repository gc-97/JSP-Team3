<%-- 
    Document   : show_trash_mail
    Created on : 2021. 5. 25., 오전 3:57:29
    Author     : ldh22
    기능 : 휴지통 상세 보기
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>휴지통 메일 보기</title>
        <link type="text/css" rel="stylesheet" href="css/main_style.css" />
    </head>
    <body>

        <jsp:include page="header.jsp" />

        <div id="sidebar">
            <p> <a href="send_mail.jsp"> 이전 메뉴로 </a> </p>
        </div>

        <div id="msgBody">

            <%
                String title = request.getParameter("title");
                String date = request.getParameter("date");

                Connection conn = null;
                PreparedStatement psmt = null;

                String dbURL = "jdbc:mysql://34.64.170.168:3306/jspmail?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
                String dbID = "yoonjsp";
                String dbPassword = "jspteamproject!!!";
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
                String sql = "SELECT * FROM TRASH WHERE subject=? and date=?";

                psmt = conn.prepareStatement(sql);
                psmt.setString(1, title);
                psmt.setString(2, date);

                ResultSet rs = psmt.executeQuery();

                while (rs.next()) {
                    out.println("보낸 사람 :" + (rs.getString("username") + "\n").replace("\n", "<br>"));
                    out.println("받은 사람 :" + (rs.getString("receiver") + "\n").replace("\n", "<br>"));
                    out.println("Cc　　　　:" + (rs.getString("cc") + "\n").replace("\n", "<br>"));
                    out.println("보낸 날짜 :" + (rs.getString("date") + "\n").replace("\n", "<br>"));
                    out.println("제　　 목 :" + (rs.getString("subject") + "\n").replace("\n", "<br>"));
                    out.println("line".replace("line", "<hr>"));
                    out.println(rs.getString("body"));

                }

                psmt.close();
                rs.close();
                conn.close();

            %>


        </div>


        <jsp:include page="footer.jsp" />

    </body>
</html>
