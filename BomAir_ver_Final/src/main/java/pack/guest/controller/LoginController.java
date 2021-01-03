package pack.guest.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import pack.guest.model.LoginInter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;


@Controller
public class LoginController {

	@Autowired
	@Qualifier("loginImpl")
	private LoginInter inter;
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String goLoginPage() {
		System.out.println("Login");
		return "login";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public ModelAndView submitLogin(HttpSession session, @RequestParam("g_id") String userInputId, @RequestParam("g_pwd") String userInputPwd) {
		ModelAndView view=new ModelAndView();
		if(inter.loginCheck(userInputId, userInputPwd)) {
			session.setAttribute("id", userInputId);
			view.setViewName("redirect:/index.jsp");
		} else {
			view.setViewName("login");
			view.addObject("state", "loginFail");
		}
		return view;
	}
	
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public String doLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/index.jsp";
	}
	
	@RequestMapping(value="registerOk", method=RequestMethod.GET)
	public String goRegisterOk() {
		return "registerOk";
	}

}
