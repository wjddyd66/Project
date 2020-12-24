package pack.mainpage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.mainpage.model.CheckinDto;
import pack.mainpage.model.CheckinUpdateDto;
import pack.mainpage.model.ReservationInter;
import pack.mainpage.model.SeatDto;
import pack.mainpage.model.SeatInter;

@Controller
public class SeatController {
	
	@Autowired
	@Qualifier("seatInterImpl")
	private SeatInter inter;
	
	@Autowired
	@Qualifier("reservationImpl")
	private ReservationInter ReservationInter;
	
	@RequestMapping(value="webCheckIn", method=RequestMethod.GET)
	public String goWebCheckInPage() {
		return "webCheckIn";
	}
	
	@RequestMapping(value="seat", method=RequestMethod.POST)
	public ModelAndView goSeatPage(
			@RequestParam("t_no") String t_no,
			@RequestParam("inwon") int inwon,
			@RequestParam("a_seat") String a_seat,
			@RequestParam("g_id") String g_id
			) {
		//System.out.println(inwon);
		//System.out.println(a_seat);
		
		String air_name=a_seat;
		ModelAndView view=new ModelAndView("seat");
		List<SeatDto> sLists = inter.seat_getData(air_name);
		List<SeatDto> plist = new ArrayList<SeatDto>();
		for(int i=0; i < sLists.size(); i++) {
			SeatDto dto = new SeatDto();
			dto.setS_no(sLists.get(i).getS_no());
			plist.add(dto);
		}
		
		view.addObject("data", plist);
		view.addObject("t_no", t_no);
		view.addObject("inwon", inwon);
		view.addObject("a_seat", a_seat);
		return view;
	}
	
	@RequestMapping(value="showCheckinInfo", method=RequestMethod.GET)
	public String goShowCheckinInfoPage() {
		return "showCheckinInfo";
	}
	
	@RequestMapping(value="showCheckinInfo", method=RequestMethod.POST)
	public ModelAndView submitShowCheckinInfo(HttpServletRequest request) {
		
		String seatTableName=request.getParameter("seatTableName");		
		String[] s_no=request.getParameterValues("s_no");
		String[] t_no=request.getParameterValues("t_no");
        String[] b_name=request.getParameterValues("b_name");
        String[] b_pp=request.getParameterValues("b_pp");
        String[] g_id=request.getParameterValues("g_id");
        int recordSu=s_no.length; // 넘어온 레코드의 수
        
        List<SeatBean> sList=new ArrayList<SeatBean>();
        for (int i = 0; i < recordSu; i++) {
        	SeatBean bean=new SeatBean();
        	bean.setS_no(s_no[i]);
        	bean.setT_no(t_no[i]);
        	bean.setB_name(b_name[i]);
        	bean.setB_pp(b_pp[i]);
        	bean.setG_id(g_id[i]);
        	sList.add(bean);
		}
        
        Map<String, Object> map = new HashMap<String, Object>(); // MAP을 이용해 담기
        map.put("seatTableName", seatTableName);
        map.put("sList", sList);
        
        int res=inter.seat_insertData(map);
        
        //
        CheckinBean bean=new CheckinBean();
 		bean.setTABLE_NAME(seatTableName);
 		bean.setG_id(g_id[0]);
 		bean.setT_no(t_no[0]);
 		System.out.println(bean.getTABLE_NAME()+", "+bean.getG_id());
 		
 		System.out.println("t_no: "+bean.getT_no());
 		List<CheckinDto> list=ReservationInter.book_selectData(bean);
 		String seatsNo="";
 		for(int i=0; i<list.size(); i++) {
 			if(i==list.size()-1) {
 				seatsNo+=list.get(i).getS_no();	
 			} else {
 				seatsNo+=list.get(i).getS_no()+",";	
 			}
 		}
 		System.out.println(seatsNo);
 		
 		CheckinUpdateDto c_updto=new CheckinUpdateDto();
 		c_updto.setSeatsNo(seatsNo);
 		c_updto.setG_id(g_id[0]);
 		c_updto.setT_no(t_no[0]);
 		System.out.println(c_updto.getSeatsNo()+", "+c_updto.getG_id()+", "+c_updto.getT_no());
 		
 		int updateRes=ReservationInter.book_upData(c_updto);
 		System.out.println("book_upData 결과: "+updateRes);
 		//
        
        ModelAndView view=new ModelAndView();
        if(res>0) {
        	Map<String, Object> map2=new HashMap<String, Object>();
        	map2.put("seatTableName", seatTableName);
        	map2.put("t_no", t_no[0]);
        	List<CheckinDto>getByDb=inter.checkin_selectCheckinData(map2);
    		
        	view.setViewName("showCheckinInfo");
			view.addObject("cList", getByDb);
        }else {
        	view.setViewName("error");
			view.addObject("state", "loginFail");
        }
        return view;
	}
	
	@RequestMapping(value="createTable", method=RequestMethod.GET)
	public String submitCreate() {
		int res=inter.seat_createTalble();
		System.out.println("건 수: "+res);
		
		return "createTable";
	}
	
 }