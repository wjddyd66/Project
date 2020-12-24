package pack.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.LineInter;

@Controller
public class SalesController {
	
	@Autowired
	private LineInter lineInter;
	
	@RequestMapping("sales")
	public ModelAndView salelist(@RequestParam("ad_date") String ad_date) {
		String ab_date = ad_date.substring(1,11);
		
		return new ModelAndView("sales1", "sales", lineInter.DatepayPart(ab_date));
	}

	
	
	 
	@RequestMapping("saletot")
	public ModelAndView saletot() {
		return new ModelAndView("saletot", "sales", lineInter.SalesDataAll());
	}
	 
}
