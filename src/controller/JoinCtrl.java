package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JoinCtrl extends HttpServlet{
 
	/*
	회원가입정보입력후 JonCtrl에  진입했을때의 요청을 처리한다. 
	입력성공 확인을 위한 ㅍ이동(location)하는것은 get방식이므로 doGet()에서 처리한다. 
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//회원가입 모든 정보 입력후 확인 눌렀을때 DB저장 성공 실패 검증폼으로 진입할 때의 요청처리.
		req.getRequestDispatcher("/member/JoinProc.jsp")
		.forward(req, resp);
	}
	

	//회원가입 정보 입력을 완료한 후 서버로 전송(submit)할때의 요청을 처리한다. post방식으로 처리하게된다. 
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//한글처리
		req.setCharacterEncoding("UTF-8");
		
		int sucOrFail;
		
		//한번에 저장하기 위해서  dto에다가 저장한다. dto를 넘긴다.
		MainDTO dto = new MainDTO();
		dto.setId(req.getParameter("id"));
		dto.setName(req.getParameter("name"));
		dto.setPass(req.getParameter("pass1"));
		dto.setTel(req.getParameter("tel1")+"-"+req.getParameter("tel2")+"-"+req.getParameter("tel3"));
		dto.setMobile(req.getParameter("mobile1")+"-"+req.getParameter("mobile2")+"-"+req.getParameter("mobile3"));
		dto.setEmail(req.getParameter("email_1")+"@"+req.getParameter("email_2"));
		dto.setAddress(req.getParameter("zip1")+"/"+req.getParameter("addr1")+"/"+req.getParameter("addr2")); 
		dto.setOpen_email(req.getParameter("open_email"));
		 
		MainDAO dao = new MainDAO();
		
		//db에 저장성공시 1을 반환한다.
		sucOrFail = dao.insertData(dto);
		
		//자원반납.
		dao.close();
		
		req.setAttribute("JoinMsg", sucOrFail);
		
		//디비자원반납
		dao.close();
		
		if(sucOrFail==1) {					
			//영역에 저장된 데이터를 회원가입성공 실패 검증하는jsp로 전달하기 위해 포워드한다. 
			req.getRequestDispatcher("../member/JoinProc.jsp").forward(req, resp);			
		} else {
			//회원가입 실패시!!!!!
			//영역에 저장된 데이터를 전달하고 회원가입폼으로 다시 사용자를 보낸다. 포워드도함. 
			req.getRequestDispatcher("../member/join02.jsp").forward(req, resp);
		}
	}
}
