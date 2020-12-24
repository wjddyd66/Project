package pack.aspect;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Component;

@Component
public class LoginClass {
	public boolean loginCheck(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			
			if(session.getAttribute("id") == null) {
				response.sendRedirect("login");
				return false;
			}else {
				return true;
			}
		} catch (Exception e) {
			System.out.println("loginCheck err : " + e);
			return false;
		}
	}
}
