package pack.rent.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.parsing.Location;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import pack.rent.model.FileValidater;
import pack.rent.model.RentInter;
import pack.rent.model.UploadFile;

@Controller
public class UploadController {

	@Autowired
	@Qualifier("fileValidater")
	private FileValidater fileValidater;
	
	@Autowired
	@Qualifier("rentImpl")
	private RentInter inter;
	
	@RequestMapping(value= "imageinsert", method = RequestMethod.POST)
	public String fileUploaded(@ModelAttribute("uploadFile") UploadFile uploadFile, BindingResult result,
			@RequestParam("c_name") String c_name,
			@RequestParam("c_jong") String c_jong,
			@RequestParam("c_bun") String c_bun,
			@RequestParam("c_color") String c_color,
			@RequestParam("c_price") String c_price,
			@RequestParam("c_place") String c_place) {
		InputStream inputStream = null;
		OutputStream outputStream = null;
		MultipartFile file = uploadFile.getFile();
		fileValidater.validate(uploadFile, result);
	
		String fileName = file.getOriginalFilename();
	if (result.hasErrors()) {
		
		return "redirect:/admincar";
	}
	else {
		try {
			inputStream=file.getInputStream();
			
			File newFile = new File("C:/work/ssou/BomAir_ver_Final2/src/main/webapp/resources/images/"+fileName);
			
			if(!newFile.exists()) {
				newFile.createNewFile();
			}
			
			outputStream = new FileOutputStream(newFile);
			int read=0;
			byte[] bytes = new byte[1024];
			
			while((read = inputStream.read(bytes))!=-1) {
				outputStream.write(bytes,0,read);
			}
			
		} catch (Exception e) {
			System.out.println("fileUploaded Error"+e);
		}finally {
			try {
				inputStream.close();
				outputStream.close();
			} catch (Exception e2) {
				System.out.println("fileUploaded Error2"+e2);
			}
		}
	}
	HashMap<String,Object> map = new HashMap<String,Object>();
	map.put("c_name",c_name);
	map.put("c_jong",c_jong);
	map.put("c_bun",c_bun);
	map.put("c_color",c_color);
	map.put("c_price",c_price);
	map.put("c_place",c_place);
	map.put("c_image",fileName);
	boolean b = inter.InsertCar(map);
	if(b) {
		return "redirect:/admincar";
	}
	return "error";
	}
}
