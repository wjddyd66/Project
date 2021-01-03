package pack.guest.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.web.ServerProperties.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sun.mail.iap.Response;

import pack.guest.model.GuestDto;
import pack.guest.model.GuestInter;

@Controller
public class MypageController {
	
	@Autowired
	@Qualifier("guestInterImpl")
	GuestInter inter;
	
	@RequestMapping(value="mypage", method=RequestMethod.GET)
	public ModelAndView goMypage(@RequestParam("g_id") String g_id) {
		
		GuestDto gdto=new GuestDto();
		gdto=inter.selectData(g_id);
		
		ModelAndView view=new ModelAndView();
		view.setViewName("mypage");
		view.addObject("gdto", gdto);
		
		return view;
	}
	
	@RequestMapping(value="mypage", method=RequestMethod.POST)
	public String submitMypage(HttpServletResponse response, GuestBean bean) {
		boolean res=inter.upData(bean);
		System.out.println("upData res: "+res);
		
		return "redirect:/mypage?g_id="+bean.getG_id();
		
	}
	
	@RequestMapping(value="dropMember", method=RequestMethod.GET)
	public String dropMember(HttpSession session, @RequestParam("g_id") String g_id) {
		inter.delData(g_id);
		session.removeAttribute("id");
		return "redirect:/index.jsp";
	}
 }
