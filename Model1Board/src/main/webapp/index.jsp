<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<style>
	body{
		display:flex;
		justify-content: center;
		align-items: center;
		flex-direction: column;
		height:100vh;
	}
	button{
		width:300px;
		height:100px;
	}
	a{
		text-decoration: none;
	}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
</head>
</head>
<body>
	<button class="btn btn-primary fs-1 text-light" onclick="location.href='BoardList.jsp'">게시판 입장</button>
	<p style="margin-top:20px">기능만 구현한 버전</p>
	<p>Copyright &copy by 2022.오원택.All rights reserved</p>
</body>
</html>