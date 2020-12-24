package pack.guest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HeaderController {
	@RequestMapping(value="goindex", method=RequestMethod.GET)
	public String goHome() {
		return "redirect:/index.jsp";
	}
}
