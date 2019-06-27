package pack.scheduler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class test {
	@RequestMapping(value="index2", method=RequestMethod.GET)
	public String goHome() {
		return "redirect:/index2.jsp";
	}
	
	@RequestMapping(value="index", method=RequestMethod.GET)
	public String goHome2() {
		return "redirect:/index.jsp";
	}
}
