package pack.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import pack.model.BookDto;
import pack.model.LineInter;

@Controller
public class DetailController {
	
	@Autowired
	private LineInter lineInter;
	
	@RequestMapping(value="detail", method=RequestMethod.POST)
	public ModelAndView details(BookBean bean) {
		BookDto dto = lineInter.detailPart(bean);
		
		return new ModelAndView("detail","dto", dto);
	}
}
