<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
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
<style>
.background {
	position: absolute;
	display: block;
	top: 0;
	left: 0;
	z-index: 0;
}

.root-container {
	display: flex;
	height: calc(100% - 72px);
	justify-content: center;
	align-items: center;
}

.content {
	font-size: 6vw;
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<canvas class="background"></canvas>
	<div class="root-container">
		<div class="content">404 Not Found</div>
	</div>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/particlesjs/2.2.3/particles.min.js" type="text/javascript"></script>
	<script src="static/js/main.js"></script>
	<script type="text/javascript">
		window.onload = function() {
			Particles.init({
				selector: ".background",
			});
		};
	</script>
</body>
</html>
