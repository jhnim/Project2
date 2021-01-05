package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberViewCtrl extends HttpServlet{
	/*
	 서블릿이 요청을 받을때 doGet(), doPost()를 통해 처리하게 되지만, service()는 위 두가지 방식의 요청을 동시에 처리할 수 있다.
	 */
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 회원 아이디
		String id = req.getParameter("id");
		
		MainDAO dao = new MainDAO();
		
		//일련번호에 해당하는 출력할 게시물을 가져온다.
		MainDTO dto = dao.memberView(id);

		//커넥션풀에 객체반납
		dao.close();
		
		//request영역에 DTO객체저장
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/admin/MemberView").forward(req, resp);
	}
}
