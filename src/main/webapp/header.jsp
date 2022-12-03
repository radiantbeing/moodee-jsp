<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header class="header">
 <div class="header__logo">
   <div class="logo">
     <div class="logo__img"></div>
     <a class="logo__name" href="./index.jsp">MOODEE</a>
     <h1 class="u-dp-blind">MOODEE</h1>
   </div>
   <div class="header__toggle"></div>    
 </div>
 <div class="header__links">
	    <div class="header__nav">
  	<nav class="nav">
  		<ul class="nav__container">
  			<li class="nav__item"><a href="index.jsp">HOME</a></li>
  			<li class="nav__item"><a href="shuffle.jsp">SHUFFLE</a></li>
  			<li class="nav__item"><a href="mlog.jsp">M-LOG</a></li>
  		</ul>
  	</nav>
  </div>
  <div class="header__sign">
  	<div class="sign">  	
	  	<a class="sign__button" href="manage.jsp">Manage</a>
  	</div>
  </div>
  <div class="header__lang">
  	<div class="lang">
 			<a class="lang__item" href="language_process.jsp?language=ko">KO</a>
 			<span class="lang__item">|</span>
 			<a class="lang__item" href="language_process.jsp?language=en">EN</a>
  	</div>
  </div>
 </div>
</header>