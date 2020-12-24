package pack.mainpage.model;

import java.util.List;
import java.util.Map;

import pack.mainpage.controller.SeatBean;

public interface SeatInter {

	public List<SeatDto> seat_getData(String air_name);
	
	public int seat_insertData(Map<String, Object> map);
	
	public List<CheckinDto> checkin_selectCheckinData(Map<String, Object> map2);
	
	public int seat_createTalble();
	
}
