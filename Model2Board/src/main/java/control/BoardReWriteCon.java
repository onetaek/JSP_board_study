package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BoardReWriteCon
 */
@WebServlet("/BoardReWriteCon.do")
public class BoardReWriteCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}
	
	protected void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int ref = Integer.parseInt(request.getParameter("ref"));
		System.out.println("1111111111");
		int re_step = Integer.parseInt(request.getParameter("re_step"));
		System.out.println("2222222222");
		int re_level = Integer.parseInt(request.getParameter("re_level"));
		System.out.println("33333333");
		request.setAttribute("ref", ref);
		request.setAttribute("re_step", re_step);
		request.setAttribute("re_level",re_level);
		
		RequestDispatcher dis = request.getRequestDispatcher("BoardReWriteFrom.jsp");
		dis.forward(request,response);
	}

}
