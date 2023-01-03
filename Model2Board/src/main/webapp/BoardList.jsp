<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	
	<c:if test="${msg!=null }">
		<script type="text/javascript">
			alert("비밀번호가 틀렸습니다.");
		</script>
	</c:if>
	
	<h2 class="bg-secondary text-lgiht" style="margin:0;">전체 게시글 보기</h2>
	<table class="table table-dark table-striped-columns table-hover">
		<tr>
			<td colspan="5">
				<input type="button" onclick="location.href='BoardWriteForm.jsp'" value="글쓰기"/>
			</td>
		</tr>
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
		<c:set var="number" value="${number }"/>
		<c:forEach var="bean" items="${v }">
		
		<tr>
			<td>${number }</td>
			<td>
				<c:if test="${bean.re_step > 1 }">
				<c:forEach var="j" begin="1" end="${(bean.re_step-1)*5 }">
				 &nbsp;
				</c:forEach>
				</c:if>
				<a href="BoardInfoControl.do?num=${bean.num }">${bean.subject}</a>
			</td>
			<td>${bean.writer }</td>
			<td>${bean.reg_date }</td>
			<td>${bean.readcount }</td>
		</tr>
		<c:set var="number" value="${number -1 }"/>
		</c:forEach>
		
	</table>
	<!-- 페이지 카운터링 소스 -->
	<p style="text-align:center;">
	<c:if test="${count>0 }">
	<c:set var="pageCount" value="${count / pageSize + (count%pageSize == 0 ? 0 : 1 ) }" />
	<c:set var="startPage" value="${1 }"/>
	
	<c:if test="${currentPage %10 != 0 }">
		<!-- 결과를 정수형으로 리턴 받아야 하기에 fmt -->
		<fmt:parseNumber var="result" value="${currentPage/10 }" integerOnly="true" />
		<c:set var="startPage" value="${result*10+1 }"/>
	</c:if>
	<c:if test="${currentPage %10 == 0 }">
		<!-- 결과를 정수형으로 리턴 받아야 하기에 fmt -->
		<c:set var="startPage" value="${(result-1)*10+1 }"/>
	</c:if>
	
	<!-- 화면에 보여질 페이지 처리숫자 처리 -->
	<c:set var="pageBlock" value="${10 }"/>
	<c:set var="endPage" value="${startPage + pageBlock -1 }"/>
	
	<c:if test="${endPage>pageCount }">
		<c:set var="endPage" value="${pageCount }"/>
	</c:if>
	
	<!-- 이전링크를 걸지 파악 -->
	<c:if test="${startPage>10 }">
		<a href='BoardListCon.do?pageNum=${startPage-10 }'>[이전]</a>
	</c:if>
	
	<!-- 페이징처리 -->
	<c:forEach var="i" begin="${startPage }" end="${endPage }">
		<a href='BoardListCon.do?pageNum=${i}'>[${i }]</a>
	</c:forEach>
	
	<!-- 다음 -->
	<c:if test="${endPage<pageCount }">
		<a href='BoardListCon.do?pageNum=${startPage+10 }'>[다음]</a>
	</c:if>
	</c:if>
	</p>
</body>
</html>