package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardBean;
import model.BoardDAO;

@WebServlet("/BoardWriteProcCon.do")
public class BoardWriteProcCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request,response);
	}
	
	protected void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//빈클래스로 데이터를 읽어드림
		request.setCharacterEncoding("UTF-8");
		BoardBean bean = new BoardBean();
		bean.setWriter(request.getParameter("writer"));
		bean.setSubject(request.getParameter("subject"));
		bean.setEmail(request.getParameter("email"));
		bean.setPassword(request.getParameter("password"));
		bean.setContent(request.getParameter("content"));
		
		BoardDAO bdao = new BoardDAO();
		bdao.insertBoard(bean);
		
		RequestDispatcher dis = request.getRequestDispatcher("BoardListCon.do");
		dis.forward(request,response);
	}
	
}
