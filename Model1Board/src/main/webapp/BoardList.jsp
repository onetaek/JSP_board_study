<%@page import="java.util.Vector"%>
<%@page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판목록</title>
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
	<h2 class="bg-secondary text-light" style="margin: 0;text-align: center;">전체 게시글 보기</h2>
	<!-- 게시글 보기에 카운터링을 설정하기위한 변수들을 선언 -->
	<%
	//화면에 보여질 게시글의 개수를 지정 
	int pageSize = 10;

	//현재 카운터를 클릭한 번호 값을 읽어 옴 
	String pageNum = request.getParameter("pageNum");

	//만약 처음  boardlist.jsp를 클릭하거나 수정 삭제 등 다른 게시글에서 이 페이지로 넘어오면 pageNum값이 없기에 null값 처리 
	if (pageNum == null) {
		pageNum = "1";
	}

	int count = 0; // 전체 글의 갯수를 저장하는 변수 
	int number = 0;//페이지 넘버링 변수

	//현재 보고자 하는 페이지 숫자를 지정
	int currentPage = Integer.parseInt(pageNum);

	//전체 게시글의 내용을 jsp쪽으로 가져와야함
	BoardDAO bdao = new BoardDAO();
	//전체 게시글의 갯수를 읽어드린 메소드 호출(전체가 몇개인지를 알아야 카운터링 숫자를 정할수있음)
	count = bdao.getAllCount();

	//현재 페이지에 보여줄 시작 번호를 설정 = 데이터 베이스에서 불러올 시작번호
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;

	//최신글 10개를 기준으로  게시글을 리턴 받아주는 메소드 호출
	Vector<BoardBean> vec = bdao.getAllBoard(startRow, endRow);

	//테이블에 표시할 번호 지정
	number = count - (currentPage - 1) * pageSize;

	//전체게시글들 리턴 받아주는 소스
	%>

	<table class="table table-dark table-striped-columns table-hover">
		<tr>
			<td colspan="5" align="right"><input type="button" value="글쓰기"
				onclick="location.href='BoardWriteForm.jsp'"></td>
		</tr>
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
		<%
		for (int i = 0; i < vec.size(); i++) {
			BoardBean bean = vec.get(i);
		%>
		<tr>
			<td><%=number--%></td>
			<td>
				<a href="BoardInfo.jsp?num=<%=bean.getNum()%>"
				style="text-decoration: none;"> <%
 				if (bean.getRe_step() > 1) {
 					for (int j = 0; j < (bean.getRe_step() - 1) * 5; j++) {
 				%>&nbsp;<%
 				//답글의 들여쓰기를 위한 for문
 				}
 			}
 			%> <%=bean.getSubject()%>
				</a>
			</td>
			<td><%=bean.getWriter()%></td>
			<td><%=bean.getReg_date()%></td>
			<td><%=bean.getReadcount()%></td>
		<%
		}
		%>
	</table>
	<p style="text-align:center;">
	<!-- 페이지 카운터링 소스를 작성 -->
	<%
		if(count > 0 ){
			//카운터링 숫자를 얼마까지 보여줄건지 결정
			int pageCount = count / pageSize + (count%pageSize == 0? 0 : 1 );
			
			//시작페이지 숫자를 설정
			int startPage = 1;
			if(currentPage % 10 != 0 ){
				startPage = (currentPage / 10)* 10 + 1;//10부터할꺼냐 11부터할꺼야
			}else{
				startPage = ((currentPage / 10)* 10 + 1)*10 + 1;//10부터할꺼냐 11부터할꺼야
			}
			
			int pageBlock = 10;//카운터링 처리 숫자
			int endPage = startPage + pageBlock - 1; //화면에 보여질 페이지의 마지막 숫자
			
			if(endPage > pageCount) endPage = pageCount;
			
			//이전이라는 링크를 만들건지 파악
			if(startPage > 10 ){
	%>
		<a href="BoardList.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
	<%		
			}
			//페이징 처리
			for(int i = startPage; i <=endPage ; i++){
			%>
				<a href="BoardList.jsp?pageNum=<%=i %>">[<%=i %>]</a>
			<%
			}
			//다음이라는 링크를 만들건지 파악
			if(endPage< pageCount){
			%>
				<a href="BoardList.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
			<%
			}
			
		}
	%>
	</p>
	
	
</body>
</html>