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
<h2 class="bg-secondary text-leight" style="margin:0;text-align: center;">게시글 수정</h2>
	<form action="BoardUpdateProcCon.do" method="post">
		<table class="table table-hover table-striped-columns table-dark">
			<tr>
				<td>작성자</td>
				<td>${bean.writer }</td>
				<td>작성일</td>
				<td>${bean.reg_date }</td>
			</tr>
			<tr>
				<td>제목</td>
				<td> &nbsp; <input type="text" name="subject" value="${bean.subject }"/></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td> &nbsp; <input type="password" name="password"/></td>
			</tr>
			<tr>
				<td>글내용</td>
				<td><textarea rows="10" cols="60" name="content">${bean.content }</textarea></td>
			</tr>
			<tr>
				<td>
					<input type="hidden" name="num" value="${bean.num }"/>
					<!-- password:내가 입력한 비밀번호값, pass:DB에 있던 비밀번호 값 -->
					<input type="hidden" name="pass" value="${bean.password }"/>
					<input type="submit" value="글수정"/> &nbsp;&nbsp;
					<input type="button" onclick ="location.href='BoardListCon.do'" value="전체글보기"/>
				<td/>
			</tr>
		</table>
	</form>
</body>
</html>