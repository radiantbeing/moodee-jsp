<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
	String title = request.getParameter("playlist_title");
	String description = request.getParameter("playlist_description");
	
	PreparedStatement pstmt = null;
	String sql = "INSERT INTO playlist(title,description) VALUES(?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, title);
	pstmt.setString(2, description);
	pstmt.executeUpdate();
	
	if (pstmt != null);
		pstmt.close();
	if (conn != null)
		conn.close();
	
	response.sendRedirect("manage.jsp?category=shuffle");
%>