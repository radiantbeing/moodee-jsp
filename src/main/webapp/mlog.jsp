<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>MOODEE</title>
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
<link rel="icon" href="favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="static/css/main.css">
<link rel="stylesheet" href="static/css/mlog.css">
</head>
<body>
	<jsp:include page="header.jsp" />
	<%
	Cookie[] cookies = request.getCookies();

	String language = "ko";
	
	try {
		for (Cookie cookie: cookies) {
			if (cookie.getName().equals("language")) {
				language = cookie.getValue();
				break;
			}
		}
	} catch (Exception e) {
		Cookie cookie_lang = new Cookie("language", "ko");
		response.addCookie(cookie_lang);
	}
	%>
	<fmt:setLocale value='<%= language %>' />
	<fmt:setBundle basename="bundle.mdBundle" var="resourceBundle" />
	<main class="root-container mlog">
		<div class="mlog__diary">
		<h2>M-LOG</h2>
		<p><fmt:message key="mlog_subtitle" bundle="${resourceBundle}" /></p>
		<div class="diary">
		<%@ include file="dbconn.jsp" %>
		<%
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy.MM.dd HH:mm");
		
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				String sql = "SELECT * FROM post ORDER BY date DESC";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
		%>
			<div class="post">
				<div class="post__date"><%= simpleDate.format(rs.getTimestamp("date")) %></div>
				<div class="post__content">
					<a href="https://www.youtube.com/watch?v=<%= rs.getString("videoId") %>" target="_blank">
						<img class="post__img" src="https://img.youtube.com/vi/<%= rs.getString("videoId") %>/maxresdefault.jpg"></img>
					</a>
					<div class="post__text-box">
						<div class="post__info post__info--title"><fmt:message key="mlog_songTitle" bundle="${resourceBundle}" /> | <%= rs.getString("songTitle") %></div>
						<div class="post__info post__info--artist"><fmt:message key="mlog_artist" bundle="${resourceBundle}" /> | <%= rs.getString("artist") %></div>						
						<div class="post__body"><%= rs.getString("article") %></div>
					</div>
				</div>
			</div>
			<hr />
		<%
			}
		} catch (SQLException ex) {
			out.println("SQLException: " + ex.getMessage());
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		%>
		</div>
		</div>
	</main>
	<script src="static/js/main.js"></script>
</body>
</html>
