<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
	String videoId = request.getParameter("post_videoId");
	String songTitle = request.getParameter("post_songTitle");
	String artist = request.getParameter("post_artist");
	String article = request.getParameter("post_article");
	
	PreparedStatement pstmt = null;
	String sql = "INSERT INTO post VALUES(?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
	pstmt.setString(2, videoId);
	pstmt.setString(3, songTitle);
	pstmt.setString(4, artist);
	pstmt.setString(5, article);
	pstmt.executeUpdate();
	
	if (pstmt != null);
		pstmt.close();
	if (conn != null)
		conn.close();
	
	response.sendRedirect("mlog.jsp");
%>