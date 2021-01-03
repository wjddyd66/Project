package pack.rent.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import pack.rent.model.FileValidater;
import pack.rent.model.RentDto;
import pack.rent.model.RentInter;
import pack.rent.model.UploadFile;

@Controller
public class RentController {
	
	@Autowired
	@Qualifier("rentImpl")
	private RentInter inter;
	
	@RequestMapping(value="rent", method=RequestMethod.POST)
	public ModelAndView goRentPage(@RequestParam("aa") String RentPlaceTd,
			@RequestParam("bb") String RentDateChoose,
			@RequestParam("cc") String ReturnDateChoose) {
		System.out.println(RentDateChoose);
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("RentPlaceTd",RentPlaceTd);
		map.put("RentDateChoose",RentDateChoose);
		map.put("ReturnDateChoose",ReturnDateChoose);
		ModelAndView view=new ModelAndView("rent");
		List<RentDto> cLists = inter.RentDataAll(map);
		view.addObject("data", cLists);
		view.addObject("RentDateChoose", RentDateChoose);
		view.addObject("ReturnDateChoose", ReturnDateChoose);
		return view;
	}
	
	@RequestMapping("rentReservation")	
	public String submitRentCar(@RequestParam("RentDateChoose") String RentDateChoose,
			@RequestParam("ReturnDateChoose") String ReturnDateChoose,
			@RequestParam("rentNum") String rentNum,
			@RequestParam("rentId") String rentId,
			HttpServletRequest request, HttpServletResponse response) {
		System.out.println(RentDateChoose + " " + ReturnDateChoose + " " + rentNum);
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("r_no",rentNum);
		map.put("c_daeil",RentDateChoose);
		map.put("c_banil",ReturnDateChoose);
		map.put("g_id",rentId);
		boolean b = inter.submitRent(map);
		if(b) {
			return "redirect:/admincar";			
		}
		return "error";
	}
	
	@RequestMapping("gomycarpage")
	public ModelAndView gopage(@RequestParam("id") String rentId, HttpServletRequest request, HttpServletResponse response) {
		List<RentDto> myList = inter.MyRentPage(rentId);
		ModelAndView myView=new ModelAndView("mycarpage");
		myView.addObject("data",myList);	
		return myView;
	}
	
	@RequestMapping("admincar")
	public ModelAndView adminCar() {
		List<RentDto> myList = inter.AdminCar();
		ModelAndView myView=new ModelAndView("mycarpage");
		myView.addObject("data",myList);
		return myView;
	}
	
	@RequestMapping("deleteRent")
	public String deleteReservation(@RequestParam("carno") String carno,
			@RequestParam("dail") String dail,
			@RequestParam("banil") String banil,
			@RequestParam("id") String id) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("r_no",carno);
		map.put("c_daeil",dail);
		map.put("c_banil",banil);
		map.put("g_id",id);
		boolean b = inter.DeleteRent(map);
		if(b) {
			return "redirect:/admincar";
		}
		return "redirect:/admincar";
	}
	
	@RequestMapping("carAll")
	public ModelAndView carAll() {
		List<RentDto> myList = inter.CarAll();
		ModelAndView view = new ModelAndView("mycarpage");
		view.addObject("cardata",myList );
		return view;
	}
	
	@RequestMapping(value = "ListPopup", method = RequestMethod.GET)
	public void popupGet(Model model) throws Exception{
		List<RentDto> myList = inter.CarAll();
		model.addAttribute("cardata", myList);
	}

	@RequestMapping("deleteCar")
	public String deleteCar(@RequestParam("no") String no, @RequestParam("name") String name) {
		boolean b = inter.DeleteCar(no);
		boolean b2 = inter.deleteCarRent(no);
		File file = new File("C:/work/ssou/BomAir_ver_Final2/src/main/webapp/resources/images/"+name);
		if( file.exists() ){
            if(file.delete()){
                System.out.println("파일삭제 성공");
            }else{
                System.out.println("파일삭제 실패");
            }
        }else{
            System.out.println("파일이 존재하지 않습니다.");
        }
		
		if(b || b2) {
			return "redirect:/ListPopup";
		}
		return "error";
	}

}
