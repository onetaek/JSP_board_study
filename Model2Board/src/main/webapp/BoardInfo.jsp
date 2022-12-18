<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<h2 class="bg-secondary text-light" style="margin:0;text-align: center;">게시글 보기</h2>
	<table class="table table-dark table-striped table-hover">
		<tr>
			<td>글번호</td>
			<td>${bean.num }</td>
			<td>조회수</td>
			<td>${bean.readcount }</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${bean.writer }</td>
			<td>작성일</td>
			<td>${bean.reg_date }</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${bean.email }</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${bean.subject }</td>
		</tr>
		<tr>
			<td>글 내용</td>
			<td>${bean.content }</td>
		</tr>
		<tr>
			<td>
				<input type = "button" value="답글쓰기" 
				onclick="location.href='BoardReWriteCon.do?num=${bean.num }&ref=${bean.ref }&re_step=${bean.re_step }&re_level=${bean.re_level }'"/>
				<input type = "button" value="수정하기" onclick = "location.href='BoardUpdateCon.do?num=${bean.num }'"/>
				<input type = "button" value="삭제하기" onclick = "location.href='BoardDeleteCon.do?num=${bean.num }'"/>
				<input type = "button" value="목록보기" onclick = "location.href='BoardListCon.do'"/>
			</td>
		</tr>
	</table>
</body>
</html>