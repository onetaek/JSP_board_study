<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">  
<meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<title>Insert title here</title>
</head>
<body>
<table class="table table-striped" width="100%" cellpadding="0" cellspacing="0" border="1">

<tr>
	<td>번호</td>
	<td>이름</td>
	<td>제목</td>
	<td>날짜</td>
	<td>조회수</td>
</tr>

<c:forEach items="${list}" var="dto"> <!-- list의 길이만큼 반복함. list 안에 있는 값 = dto -->
<tr>
<td>${dto.bId }</td>
<td>${dto.bName }</td>
<td> <!-- 들여쓰기 -->
	<c:forEach begin="1" end="${dto.bIndent}">-</c:forEach>
	<a href="content_view.do?bId=${dto.bId}">${dto.bTitle}</a> <!-- 해당 글로 이동 -->
</td>
<td>${dto.bDate}</td>
<td>${dto.bHit}</td>
</tr>
</c:forEach>
<tr>
	<td colspan="5"> <a href="write_view.do">글작성</a> </td>
</tr>

</table>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>


</body>
</html>





