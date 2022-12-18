<%@page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 정보</title>
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
	int num = Integer.parseInt(request.getParameter("num").trim());//공백 제거후 정수형으로 바뀜
	
	//데이터 베이스 접근
	BoardDAO bdao = new BoardDAO();
	//boardbean타입으로 하나의 게시글을 리턴
	BoardBean bean = bdao.getOneBoard(num);
%>
	<h2 class="bg-secondary text-light" style="margin:0;text-align: center;">게시글 보기</h2>
	<table class="table table-dark table-striped table-hover">
		<tr>
			<td>글번호</td>
			<td><%=bean.getNum() %></td>
			<td>조회수</td>
			<td><%=bean.getReadcount() %></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=bean.getWriter() %></td>
			<td>작성일</td>
			<td><%=bean.getReg_date() %></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><%=bean.getEmail() %></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=bean.getSubject()%></td>
		</tr>
		<tr>
			<td>글 내용</td>
			<td><%=bean.getContent() %></td>
		</tr>
		<tr>
			<td>
				<input type = "button" value="답글쓰기" 
				onclick="location.href='BoardReWriteFrom.jsp?num=<%=bean.getNum()%>&ref=<%=bean.getRef()%>&re_step=<%=bean.getRe_step()%>&re_level=<%=bean.getRe_level()%>'"/>
				<input type = "button" value="수정하기" onclick = "location.href='BoardUpdateForm.jsp?num=<%=bean.getNum() %>'"/>
				<input type = "button" value="삭제하기" onclick = "location.href='BoardDeleteForm.jsp?num=<%=bean.getNum()%>'"/>
				<input type = "button" value="목록보기" onclick = "location.href='BoardList.jsp'"/>
			</td>
		</tr>
	</table>

</body>
</html>