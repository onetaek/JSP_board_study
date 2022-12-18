<%@page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판삭제</title>
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
<body>
<%
	BoardDAO bdao = new BoardDAO();
	
	int num = Integer.parseInt(request.getParameter("num"));
	//하나의 게시글을 리턴
	BoardBean bean = bdao.getOneUpdateBoard(num);
%>
<h2 class="bg-secondary text-light" style="margin:0;text-align: center;">게시글 삭제</h2>
<form action="BoardDeleteProc.jsp" method="post">
	<table class="table table-dark table-hover table-striped-columns">
		<tr>
			<td>작성자</td>
			<td><%=bean.getWriter()%></td>
			<td>작성일</td>
			<td><%=bean.getReg_date() %></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=bean.getSubject() %></td>
		</tr>
		<tr>
			<td>패스워드</td>
			<td><input type="password" name="password" size="60"/></td>
		<tr>
		<tr>
			<td>
				<input type="hidden" name="num" value="<%=bean.getNum() %>"/>
				<input type="submit" value="글삭제"/> &nbsp;&nbsp;
				<input type="button" onclick="location.href='BoardList.jsp'" value="목록보기"/>
			</td>
		</tr>		
	</table>
</form>













</body>
</html>