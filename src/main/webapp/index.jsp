<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>MOODEE</title>
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
<link rel="icon" href="favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="static/css/main.css">
<link rel="stylesheet" href="static/css/home.css"> 
</head>
<body>
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
	<jsp:include page="header.jsp" />
	<div class="root-container home">
		<div class="home__intro">
			<div class="intro">
				<div class="intro__container">
					<%@ include file="dbconn.jsp" %>
					<%
					PreparedStatement pstmt = null;
					ResultSet rsPlaylist = null;
					ResultSet rsSong = null;
					
					try {
					String sql = "SELECT * FROM playlist ORDER BY RAND()";
					pstmt = conn.prepareStatement(sql);
					rsPlaylist = pstmt.executeQuery();
							
					while (rsPlaylist.next()) {
						sql = "SELECT * FROM song WHERE playlist = " + String.valueOf(rsPlaylist.getInt("id")) + " ORDER BY RAND() LIMIT 1";
						pstmt = conn.prepareStatement(sql);
						rsSong = pstmt.executeQuery();
						if (!rsSong.next()) 
							continue;
					%>
					<div class="intro__item">
						<div class="intro__info">
							<h2 class="intro__heading"><%=rsPlaylist.getString("title")%></h2>
							<p class="intro__description"><%=rsPlaylist.getString("description")%></p>
							<div class="intro__controls">
								<button type="button" class="intro__play"
									onclick="location.href='./shuffle.jsp?playlist_id=<%=rsPlaylist.getInt("id")%>'">PLAY
									▶</button>
								<div class="intro__changers">
									<button type="button"
										class="intro__changer intro__changer--prev">← <fmt:message key="home_prev" bundle="${resourceBundle}" /></button>
									<button type="button"
										class="intro__changer intro__changer--next"><fmt:message key="home_next" bundle="${resourceBundle}" /> →</button>
								</div>
							</div>
						</div>
						<div class="intro__song">
							<div class="intro__song-img"
								style="background-image: url('<%= rsSong.getString("thumbnailUrl") %>')"></div>
							<div class="intro__song-name"><%= rsSong.getString("title") %></div>
						</div>
					</div>
					<%
						}
					} catch (SQLException ex) {
						System.out.println("SQLException: " + ex.getMessage());
					} finally {
						if (rsSong != null)
							rsSong.close();
						if (rsPlaylist != null)
							rsPlaylist.close();
						if (pstmt != null)
							pstmt.close();
						if (conn != null)
							conn.close();
					}
					%>
				</div>
				<div class="intro__progress-bar"></div>
			</div>
		</div>
		<div class="home__welcome">
		<canvas class="background"></canvas>
			<div class="welcome">
				<div class="welcome__clock">AM 00:00:00</div>
				<div class="welcome__message">
					<h3 class="welcome__heading">moodee</h3>
					<p class="welcome__body"><fmt:message key="home_subtitle" bundle="${resourceBundle}" /></p>		
				</div>
			</div>
		</div>
	</div>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/particlesjs/2.2.3/particles.min.js" type="text/javascript"></script>
	<script src="static/js/main.js"></script>
	<script src="static/js/home.js"></script>
</body>
</html>
