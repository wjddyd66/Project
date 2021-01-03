package pack.rent.model;

import java.util.HashMap;
import java.util.List;



public interface RentInter {
	public List<RentDto> RentDataAll(HashMap<String,Object> map);
	
	public boolean submitRent(HashMap<String,Object> map);
	
	public List<RentDto> RentDataAll2(String RentPlaceTd);
	
	public List<RentDto> MyRentPage(String g_id);
	
	public List<RentDto> AdminCar();
	
	public boolean DeleteRent(HashMap<String,Object> map);
	
	public boolean InsertCar(HashMap<String,Object> map);
	
	public List<RentDto> CarAll();
	
	public boolean DeleteCar(String r_no);
	
	public boolean deleteCarRent(String r_no);
}


