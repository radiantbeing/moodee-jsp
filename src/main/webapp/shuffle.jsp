<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="static/css/shuffle.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css" />
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
	<main class="root-container shuffle">
		<div class="shuffle__playlists">
			<h2>SHUFFLE</h2>
			<p><fmt:message key="shuffle_subtitle" bundle="${resourceBundle}" /></p>
			<div class="playlists-grid">
				<div class="playlists-grid__container">
					<%@ include file="dbconn.jsp" %>
					<%
					String playlistId = request.getParameter("playlist_id");
					
					if (playlistId == null)
						playlistId = "-1";
					
					PreparedStatement pstmt = null;
					ResultSet rsPlaylist = null;
					ResultSet rsSong = null;
					
					try {
						String sql = "SELECT * FROM playlist";
						pstmt = conn.prepareStatement(sql);
						rsPlaylist = pstmt.executeQuery();
						while (rsPlaylist.next()) {
							sql = "SELECT * FROM song WHERE playlist = " + String.valueOf(rsPlaylist.getInt("id")) + " ORDER BY RAND() LIMIT 1";
							pstmt = conn.prepareStatement(sql);
							rsSong = pstmt.executeQuery();
							if (!rsSong.next()) 
								continue;
					%>
					<div 
						<%= playlistId.equals(String.valueOf(rsPlaylist.getInt("id"))) ? "class=\"playlists-grid__item playlists-grid__item--active\"" : "class=\"playlists-grid__item\"" %> 
						style="background-image: url('<%= rsSong.getString("thumbnailUrl") %>')" 
						onclick='location.href="./shuffle.jsp?playlist_id=<%= rsPlaylist.getInt("id") %>"'>
						<span class="playlists-grid__id u-dp-blind"><%= rsPlaylist.getInt("id") %></span>
						<%= rsPlaylist.getString("title") %>
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
			</div>
		</div>
		<div class="shuffle__player">
			<div class="player">
				<div class="player__song">
					<div class="player__img"></div>
					<div class="player__info">
						<%
						if (request.getParameter("playlist_id") == null) {
						%>
							<div class="player__title"><fmt:message key="shuffle_selectWait" bundle="${resourceBundle}" /></div>
						<%
						}
						%>
						<%
						if (request.getParameter("playlist_id") != null) {
						%>
							<div class="player__title"><fmt:message key="shuffle_loading" bundle="${resourceBundle}" /></div>
						<%
						}
						%>
						<div class="player__sub player__sub--id"></div>
						<div class="player__sub player__sub--time"></div>
					</div>
				</div>
				<div class="player__controls">
					<div class="player__control player__control--vol-down"></div>
					<div class="player__control player__control--prev"></div>
					<div class="player__control player__control--play"></div>
					<div class="player__control player__control--pause"></div>
					<div class="player__control player__control--next"></div>
					<div class="player__control player__control--vol-up"></div>
				</div>
			</div>
		</div>
	</main>
	<div id="player" class="u-dp-blind"></div>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
	<script src="static/js/main.js"></script>
	<script src="static/js/shuffle.js"></script>
</body>
</html>
