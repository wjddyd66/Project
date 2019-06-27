package pack.gong.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pack.gong.model.gongDto;
import pack.gong.model.gongImpl;

@Controller
public class gongController {
	private int tot; // 전체 레코드 수
	private int pList = 12; // 페이지 당 출력 자료 수
	private int pageSu; // 전체 페이지 수
	private int blocksu; // 전체 Block 을 몇개로 나눌지

	@Autowired
	@Qualifier("gongImpl")
	private gongImpl inter;

	//글 전체보기
	@RequestMapping("gong_list")
	private ModelAndView process(@RequestParam("spage") String spage, HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (request.getParameter("sword") == null)
			map.put("sword", "All");
		else
			map.put("sword", request.getParameter("sword"));
		
		tot = inter.Pagesu(map);

		if (tot % pList == 0)
			pageSu = tot / pList;
		else
			pageSu = tot / pList + 1;

		int page = Integer.parseInt(spage);

		if (page % 5 != 0)
			blocksu = page / 5 + 1;
		else
			blocksu = page / 5;

		List<gongDto> list = inter.selectList(map);
		int k = 0;
		ArrayList<gongDto> list2 = new ArrayList<gongDto>();
		try {
			while (k < pList) {
				gongDto dto = new gongDto();
				dto.setNum(list.get(((page - 1) * pList) + k).getNum());
				dto.setTitle(list.get(((page - 1) * pList) + k).getTitle());
				dto.setBdate(list.get(((page - 1) * pList) + k).getBdate());
				dto.setReadcnt(list.get(((page - 1) * pList) + k).getReadcnt());
				list2.add(dto);
				k++;
			}
		} catch (Exception e) {
			System.out.println("페이지수 예외처리" + e);
		}

		ModelAndView view = new ModelAndView();
		view.setViewName("gong_main");
		view.addObject("list", list2);
		view.addObject("su", pageSu);
		view.addObject("bsu", blocksu);
		view.addObject("sword", map.get("sword"));
		return view;
	}

	//index의 요약된 자료 보기
	@RequestMapping("gong_main")
	@ResponseBody
	public List<gongDto> getJson() {
		List<gongDto> list = inter.selectMain();
		ArrayList<gongDto> list2 = new ArrayList<gongDto>();
		int k = 0;
		try {
			while (k < list.size()) {
				gongDto dto = new gongDto();
				dto.setTitle(list.get(k).getTitle());
				dto.setNum(list.get(k).getNum());
				if (list.get(k).getCon().length() > 50)
					dto.setCon(list.get(k).getCon().substring(0, 48) + "...");
				else
					dto.setCon(list.get(k).getCon());
				list2.add(dto);
				k++;
			}
		} catch (Exception e) {

		}
		return list2;
	}

	//새글 쓰기 양식
	@RequestMapping(value="gong_write",method = RequestMethod.GET)
	private String gong_write() {
		return "gong_write";
	}
	
	//새 글 쓰기
	@RequestMapping(value="gong_write",method = RequestMethod.POST)
	private void process_register(HttpServletResponse response, @RequestParam("subject") String subject,
			@RequestParam("date") String date, @RequestParam("content") String content) {
		int x = inter.maxNum();
		gongBean bean = new gongBean();
		bean.setBdate(date);
		bean.setTitle(subject);
		bean.setCon(content);
		bean.setNum(x + 1);
		inter.register(bean);
		try {
			response.sendRedirect("gong_list?spage=1");
		} catch (IOException e) {
			System.out.println("insert Error");
		}
	}

	//자세한 내용 보기
	@RequestMapping("gong_detail")
	private ModelAndView processDetail(@RequestParam("num") int num, @RequestParam("spage") int spage,
			HttpServletRequest request) {
		String sword = "";
		if (request.getParameter("sword") == null)
			sword = "All";
		else
			sword = request.getParameter("sword");

		inter.updateNum(num);
		gongDto dto = inter.detail(num);
		ModelAndView view = new ModelAndView();
		view.setViewName("gong_detail");
		view.addObject("dto", dto);
		view.addObject("spage", spage);
		view.addObject("sword", sword);
		return view;
	}

	//삭제하기
	@RequestMapping("gong_delete")
	private void processDelete(HttpServletResponse response, @RequestParam("num") String num, @RequestParam("spage") String spage, HttpServletRequest request) {
		String sword = "";
		if (request.getParameter("sword") == null)
			sword = "All";
		else
			sword = request.getParameter("sword");
		
		String word = URLEncoder.encode(sword);
		
		int x = Integer.parseInt(num);
		inter.delete(x);
		try {
			response.sendRedirect("gong_list?spage=" + spage + "&sword=" + word);
		} catch (IOException e) {
			System.out.println("Delete Error" + e);
		}
	}

	//업데이트 양식으로 가기
	@RequestMapping(value = "gong_update", method = RequestMethod.GET)
	private ModelAndView processUpdate(@RequestParam("num") int num, @RequestParam("spage") int spage,
			HttpServletRequest request) {
		String sword = "";
		if (request.getParameter("sword") == null)
			sword = "All";
		else
			sword = request.getParameter("sword");
		inter.updateNum(num);
		gongDto dto = inter.detail(num);
		ModelAndView view = new ModelAndView();
		view.setViewName("gong_update_form");
		view.addObject("dto", dto);
		view.addObject("spage", spage);
		view.addObject("sword", sword);
		return view;
	}
	
	//업데이트
	@RequestMapping(value = "gong_update", method = RequestMethod.POST)
	private void processUpdate(HttpServletResponse response, 
			HttpServletRequest request,
			@RequestParam("num") int num, 
			@RequestParam("spage") int spage,
			@RequestParam("subject") String subject,
			@RequestParam("date") String date, 
			@RequestParam("content") String content) {
		
		String sword = "";
		if (request.getParameter("sword") == null)
			sword = "All";
		else
			sword = request.getParameter("sword");
		
		String word = URLEncoder.encode(sword);
	
		gongBean bean = new gongBean();
		bean.setBdate(date);
		bean.setNum(num);
		bean.setCon(content);
		bean.setTitle(subject);
		
		inter.updateNum(num);
		inter.updateForm(bean);
		
		try {
			response.sendRedirect("gong_list?spage=" + spage + "&sword=" + word);
		} catch (IOException e) {
			System.out.println("Delete Error" + e);
		}
	}
}
