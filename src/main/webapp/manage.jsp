<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="static/css/manage.css">
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
	<%
	session.setAttribute("userID", request.getRemoteUser());
	%>
	<fmt:setLocale value='<%= language %>' />
	<fmt:setBundle basename="bundle.mdBundle" var="resourceBundle" />
	<main class="root-container main">
		<div class="main__manage">
			<h2>Hello, <%= session.getAttribute("userID") %></h2>
			<p><fmt:message key="manage_subtitle" bundle="${resourceBundle}" /></p>
			<div class="manage">
				<label class="manage__label" for="manage_select"><b><fmt:message key="manage_categoryTitle" bundle="${resourceBundle}" /></b></label>
				<select class="manage__select" name="manage_category" id="manage_select">
					<option value=""><fmt:message key="manage_categoryOption" bundle="${resourceBundle}" /></option>
					<option value="general">GENERAL</option>
					<option value="shuffle">SHUFFLE</option>
					<option value="mlog">M-LOG</option>
				</select>
				<hr />
				<%
				String category = request.getParameter("category");

				if (category == null) {
				} else if (category.equals("general")) {
				%>
				<div class="setting">
					<h3>GENERAL</h3>
					<ul>
						<li>
							<h4><fmt:message key="general_title" bundle="${resourceBundle}" /></h4>
							<form action="adjustGeneral_process.jsp" name="general_form" method="post" enctype="multipart/form-data">
								<div>
									<label for="general_logo"><fmt:message key="general_logo_file" bundle="${resourceBundle}" /></label>
									<br />
									<small><fmt:message key="general_help" bundle="${resourceBundle}" /></small>
									<p><input type="file" name="general_logo" id="general_logo" /></p>
									<input type="button" value='<fmt:message key="manage_addButton" bundle="${resourceBundle}" />' onclick="checkGeneralForm();" />
								</div>
							</form>
						</li>
					</ul>
				</div>
				<%
				} else if (category.equals("shuffle")) {
				%>
				<div class="setting">
					<h3>SHUFFLE</h3>
					<ul>
						<li>
							<h4><fmt:message key="manage_shuffle_playlistAdd" bundle="${resourceBundle}" /></h4>
							<form action="addPlaylist_process.jsp" name="playlist_form">
								<p>
									<label for="playlist_title"><fmt:message key="manage_shuffle_playlistTitle" bundle="${resourceBundle}" /></label> <br /> <input type="text" name="playlist_title" id="playlist_title" />
								</p>
								<p>
									<label for="playlist_description"><fmt:message key="manage_shuffle_playlistDescription" bundle="${resourceBundle}" /></label><br />
									<textarea name="playlist_description" id="playlist_description"></textarea>
								</p>
								<p>
									<small><fmt:message key="manage_shuffle_playlistHelp" bundle="${resourceBundle}" /></small>
								</p>
								<input type="button" value='<fmt:message key="manage_addButton" bundle="${resourceBundle}" />' onclick="checkPlaylistForm();" />
							</form>
						</li>
						<li>
							<h4><fmt:message key="manage_songAdd" bundle="${resourceBundle}" /></h4>
							<form action="addSong_process.jsp" name="song_form">
								<p>
									<label for="song_playlist"><fmt:message key="manage_song_playlist" bundle="${resourceBundle}" /></label><br />
									<select name="song_playlist" id="song_playlist">
										<%@ include file="dbconn.jsp" %>
										<%
										PreparedStatement pstmt = null;
										ResultSet rs = null;
										
										try {
											String sql = "SELECT * FROM playlist";
											pstmt = conn.prepareStatement(sql);
											rs = pstmt.executeQuery();
											while (rs.next()) {
										%>
										<option value="<%= rs.getInt("id")%>"><%=rs.getString("title")%></option>
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
									</select>
								</p>
								<p>
									<label for="song_videoId"><fmt:message key="youtubeID" bundle="${resourceBundle}" /></label>
									<br />
									<input type="text" name="song_videoId" id="song_videoId" />
								</p>
								<div class="help">
									<div class="help__item"><b><fmt:message key="YTHelp_title" bundle="${resourceBundle}" /></b></div>
									<div class="help__item"><fmt:message key="YTHelp_description" bundle="${resourceBundle}" /></div>
									<div class="help__item help__item--example"><code>https://www.youtube.com/watch?v=<b>Ss7aZxzqDaM</b></code></div>
								</div>
								<p>
									<label for="song_title"><fmt:message key="song_title" bundle="${resourceBundle}" /></label><br /> <input type="text" name="song_title" id="song_title" />
								</p>
								<p>
									<label for="song_artist"><fmt:message key="song_artist" bundle="${resourceBundle}" /></label><br /> <input type="text" name="song_artist" id="song_artist" />
								</p>
								<input type="button" value='<fmt:message key="manage_addButton" bundle="${resourceBundle}" />' onclick="checkSongForm();" />
							</form>
						</li>
					</ul>
				</div>
				<%
				} else if (category.equals("mlog")) {
				%>
				<div class="setting">
					<h3>M-LOG</h3>
					<ul>
						<li>
							<h4><fmt:message key="mlog_diaryAdd" bundle="${resourceBundle}" /></h4>
							<form action="addPost_process.jsp" name="post_form">
								<p>
									<label for="post_videoId"><fmt:message key="youtubeID" bundle="${resourceBundle}" /></label>
									<br />
									<input type="text" name="post_videoId" id="post_videoId" />
								</p>
								<div class="help">
									<div class="help__item"><b><fmt:message key="YTHelp_title" bundle="${resourceBundle}" /></b></div>
									<div class="help__item"><fmt:message key="YTHelp_description" bundle="${resourceBundle}" /></div>
									<div class="help__item help__item--example"><code>https://www.youtube.com/watch?v=<b>Ss7aZxzqDaM</b></code></div>
								</div>
								<p>
									<label for="post_songTitle"><fmt:message key="song_title" bundle="${resourceBundle}" /></label><br /> <input type="text" name="post_songTitle" id="post_songTitle" />
								</p>
								<p>
									<label for="post_artist"><fmt:message key="song_artist" bundle="${resourceBundle}" /></label><br /> <input type="text" name="post_artist" id="post_artist" />
								</p>
								<p>
									<label for="post_article"><fmt:message key="mlog_content" bundle="${resourceBundle}" /></label><br />
									<textarea name="post_article" id="post_article"></textarea>
								</p>
								<input type="button" value='<fmt:message key="manage_addButton" bundle="${resourceBundle}" />' onclick="checkPostForm();" />
							</form>
						</li>
					</ul>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</main>
	<script src="static/js/main.js"></script>
	<script src="static/js/manage.js"></script>
</body>
</html>
