package pack.mainpage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyreservationController {
		@RequestMapping("myreservation")
		public String goMyreservationSite() {
			return "myreservation";
		}
}
