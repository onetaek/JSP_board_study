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

/**
 * Servlet implementation class BoardReWriteProcCon
 */
@WebServlet("/BoardReWriteProcCon.do")
public class BoardReWriteProcCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}
	
	protected void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		BoardBean bean = new BoardBean();
		System.out.println("1111");
		bean.setWriter(request.getParameter("writer"));
		System.out.println("2222");
		bean.setSubject(request.getParameter("subject"));
		System.out.println("3333");
		bean.setEmail(request.getParameter("email"));
		System.out.println("4444");
		bean.setPassword(request.getParameter("password"));
		System.out.println("5555");
		bean.setContent(request.getParameter("content"));
		System.out.println("6666");
		bean.setRef(Integer.parseInt(request.getParameter("ref")));
		System.out.println("7777");
		bean.setRe_step(Integer.parseInt(request.getParameter("re_step")));
		System.out.println("8888");
		bean.setRe_level(Integer.parseInt(request.getParameter("re_level")));
		System.out.println("9999");
		BoardDAO bdao = new BoardDAO();
		bdao.reInsertBoard(bean);
		
		RequestDispatcher dis = request.getRequestDispatcher("BoardList.do");
		dis.forward(request,response);
	}
}
