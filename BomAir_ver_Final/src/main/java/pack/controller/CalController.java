package pack.controller;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.BookDto;
import pack.model.LineInter;



@Controller
public class CalController {
	@Autowired
	private LineInter lineInter;
	
	/*
	@RequestMapping(value = "cal", method = RequestMethod.GET)
	public String login(HttpSession session) {

		return "cal";
	}
	*/
	

	 
	@RequestMapping(value = "cal", method = RequestMethod.GET)
	public ModelAndView up() {
		List<BookDto> dto = lineInter.Datepay();
		ModelAndView view = new ModelAndView();
		String s="";
		for(int i=0;i<dto.size();i++) {
			String tot = NumberFormat.getInstance().format(Integer.parseInt(dto.get(i).getHap()));
			s+="{ title:'매출금액 : " + tot + "', start:'"+  dto.get(i).getAb_date()+"', end:'"+ dto.get(i).getAb_date() +"'},";
		}
	
		view.setViewName("cal");
		view.addObject("list",s);
		
		return view;
	}
	
	
}
