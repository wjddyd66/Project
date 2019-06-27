package pack.guest.model;

import java.util.HashMap;
import java.util.List;

import pack.guest.controller.GuestBean;

public interface GuestInter {

	boolean insData(GuestBean bean);

	GuestDto selectData(String g_id);

	boolean upData(GuestBean bean);
	
	boolean delData(String g_id);

	int idCheck(String id);

	List<HashMap<String, Object>> find_id(HashMap<String, Object> map);

}
