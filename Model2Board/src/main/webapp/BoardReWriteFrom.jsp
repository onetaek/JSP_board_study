<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답글쓰기</title>
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
	<h2 class="bg-secondary text-light" style="margin:0;text-align: center;">답변글 입력하기</h2>
	<form action="BoardReWriteProcCon.do" method="post">
		<table class="table table-hover table-dark table-striped-columns">
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer" size="60" /></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="subject" value="[답변]" size="60" /></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="email" name="email" size="60" /></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="password" size="60" /></td>
			</tr>
			<tr>
				<td>글 내용</td>
				<td><textarea rows="10" cols="60" name="content">
					</textarea></td>
			</tr>
			<tr>
				<td>
					<input type="hidden" name="ref" value="${ref }"/>
					<input type="hidden" name="re_step" value="${re_step }"/>
					<input type="hidden" name="re_level" value="${re_level }"/>
					<input type="submit" value="답글 쓰기 완료" /> 
					<input type="reset" value="취소" />
					<input onclick="location.href='BoardListCon.do'" type="button" value="전체글보기" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>