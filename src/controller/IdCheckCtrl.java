package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

public class IdCheckCtrl extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
//		req.getRequestDispatcher("/main/idChkPupup.jsp")
//			.forward(req, resp);
		//전송된 2가지 값을 가져와 변수에 저장한다.
		String id = req.getParameter("id");
		
		//패스워드 검증을 위해 model호출. 
		MainDAO dao = new MainDAO();
		//db에 값이 있는지 확인 있으면 id가 없으면  true를 리턴함.
		int jungbokid = dao.idCheck(id);
		
		//자원반납.
		dao.close();

		//아이디 검증 결과를 request영역에 저장한다. 
		req.setAttribute("id", id);
		req.setAttribute("ID_PASS", jungbokid);
		
		//디비자원반납
		dao.close();

		//영역에 저장된 데이터를 id체크 팝업창으로 전달하기 위해 포워드한다. 
		req.getRequestDispatcher("../member/idChkPupup.jsp").forward(req, resp);
		
	}
	
	//만약 아이디검증쪽에서 post방식으로 요청이 들어오더라도 처리는 doGet()에서 처리할 수 있도록 모든 요청을 토스한다. 
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}
}
