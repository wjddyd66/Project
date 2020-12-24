package pack.mail.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pack.controller.BookBean;
import pack.model.BookDto;
import pack.model.LineInter;

@Controller
public class EmailController {
		
		@Autowired
		@Qualifier("emailSender")
		private EmailSender emailSender;
		
		@Autowired
		private LineInter lineInter;
		
		@RequestMapping("Email_ticket")
		public String submit(BookBean bean) {
			BookDto dto = lineInter.detailPart(bean);
			try {
				emailSender.sendEmail(dto);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "success";
		}
		
		@RequestMapping("find_pwd")
		   @ResponseBody
		   public HashMap<String, Object> getJson(@RequestParam("name") String name,@RequestParam("tel") String tel,@RequestParam("id") String id) {
			  HashMap<String, Object> paramap = new HashMap<String, Object>();
			  HashMap<String, Object> map = new HashMap<String, Object>();
			  paramap.put("g_name",name);
		      paramap.put("g_tel",tel);
		      paramap.put("g_id",id);
		      boolean b = emailSender.sendPwd(paramap);
		      if(b==false)
		    	  map.put("result","false");
		      else
		    	  map.put("result","true");
			  return map;
		   }
		
}
