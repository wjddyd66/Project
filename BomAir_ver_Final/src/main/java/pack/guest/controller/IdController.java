package pack.guest.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pack.gong.model.gongDto;
import pack.guest.model.GuestInterImpl;

@Controller
public class IdController {

   @Autowired
   @Qualifier("guestInterImpl")
   private GuestInterImpl inter;
   
   @RequestMapping(value="id_check",method=RequestMethod.GET)
   @ResponseBody
   public HashMap<String, Object> getJson(@RequestParam("id") String id) {
      HashMap<String, Object> map = new HashMap<String, Object>();
      if(inter.idCheck(id)==1) {
         map.put("Check","fail");
         map.put("Check2","deny");
      }
      else
         map.put("Check", "success");
      return map;
   }
   
   @RequestMapping("find_id")
   @ResponseBody
   public List<HashMap<String, Object>> getJson2(@RequestParam("name") String name,@RequestParam("tel") String tel) {
	  HashMap<String, Object> paramap = new HashMap<String, Object>();
      paramap.put("g_name",name);
      paramap.put("g_tel",tel);
      System.out.println("Check Point1");
      List<HashMap<String, Object>> result = inter.find_id(paramap);
	  ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		try {
			for(int k=0;k<result.size();k++) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("id",result.get(k).get("g_id"));
				list.add(map);	
			}
			
		} catch (Exception e) {
			System.out.println("찾는 계정 없음");
		}
      
      return list;
   }
}