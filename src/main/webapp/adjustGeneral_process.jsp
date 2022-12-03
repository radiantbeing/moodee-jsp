<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
String savePath =  request.getServletContext().getRealPath("static/images");
System.out.println(savePath);
MultipartRequest multi = new MultipartRequest(request, savePath, 5 * 1024 * 1024, "utf-8");

response.sendRedirect(request.getHeader("referer"));
%>