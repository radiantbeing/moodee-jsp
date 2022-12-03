<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
	String songPlaylistId = request.getParameter("song_playlist");
	String songVideoId = request.getParameter("song_videoId");
	String songTitle = request.getParameter("song_title");
	String songArtist = request.getParameter("song_artist");
	
	PreparedStatement pstmt = null;
	String sql = "INSERT INTO song VALUES(?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, songVideoId);
	pstmt.setString(2, songTitle);
	pstmt.setString(3, songArtist);
	pstmt.setString(4, "https://img.youtube.com/vi/" + songVideoId + "/0.jpg");
	pstmt.setInt(5, Integer.parseInt(songPlaylistId));
	pstmt.executeUpdate();
	
	if (pstmt != null);
		pstmt.close();
	if (conn != null)
		conn.close();
	
	response.sendRedirect("shuffle.jsp?playlist_id=" + songPlaylistId);
%>