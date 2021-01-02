package Util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {
	/*
	 Java영역에서는 JSP의 내장객체를 바로 사용하는 것은 불가능하다. JSP에서 매개변수로 내장객체를 전달하면
	 해당 타입으로 전달받아 사용하게 된다. request, response 내장객체를 아래와 같이 사용한다. 
	 */
	public static void makeCookie(HttpServletRequest req, HttpServletResponse resp,
			String cName, String cValue, int time) {
		Cookie cookie = new Cookie(cName, cValue);
		cookie.setPath(req.getContextPath());
		cookie.setMaxAge(time);
		resp.addCookie(cookie);
		
		
	}
}
