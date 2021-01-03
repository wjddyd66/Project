package pack.model;

import java.util.HashMap;
import java.util.List;

import pack.controller.BookBean;
import pack.controller.CompleteBean;
import pack.controller.LineBean;

public interface LineInter {
	
	List<LineDto> getDataAll();
	
	LineDto selectPart(String num);
	
	List<LineDto> DatePart(LineBean bean);
	
	List<LineDto> DatePart_R(LineBean bean);
	
	boolean insData(LineBean bean);
	
	void DepartIns(CompleteBean bean);
	
	void DepartIns_R(CompleteBean bean);
	
	String MaxT();
	
	List<BookDto> myDataAll(String id);
	
	BookDto detailPart(BookBean bean);
	
	HashMap<String,Object>detailName(String g_id);
	
	// 매출
	List<BookDto> SalesDataAll();
	
	List<BookDto> Datepay();
	
	List<BookDto> DatepayPart(String ab_date);
}
