<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="dto.Song"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
response.setContentType("application/json");

String request_id = request.getParameter("playlist_id");

int playlistId = Integer.parseInt(request.getParameter("playlist_id"));

PreparedStatement pstmt = null;
ResultSet rs = null;
ArrayList<Song> songs = new ArrayList<Song>();

try {
	String sql = "SELECT * FROM song where playlist = '" + playlistId + "'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	while (rs.next()) {
		Song newSong = new Song(rs.getString("videoId"), rs.getString("title"), rs.getString("artist"));
		songs.add(newSong);
	}
} catch (SQLException ex) {
	System.out.println("SQLException: " + ex.getMessage());
} finally {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
}

JSONObject JSONObj = new JSONObject();

JSONObj.put("songs", songs);

response.getWriter().write(JSONObj.toString());
%>