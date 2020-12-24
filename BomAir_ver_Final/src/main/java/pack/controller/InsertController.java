package pack.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import pack.model.LineInter;

@Controller
public class InsertController {

	@Autowired
	private LineInter lineInter;
	
	@RequestMapping(value="insert", method=RequestMethod.GET)
	public String insert() {
		return "insform";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String submit(LineBean bean) {
		boolean b = lineInter.insData(bean);
		if(b) {
			return "redirect:/list";
		}else {			
			return "error";
		}
	}
}
