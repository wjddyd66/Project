package pack.mainpage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BookingController {
	@RequestMapping("booking")
	public String goBookingSite() {
		return "booking";
	}
}