<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String language = request.getParameter("language");

Cookie cookie_lang = new Cookie("language", language);
response.addCookie(cookie_lang);

response.sendRedirect(request.getHeader("referer"));
%>