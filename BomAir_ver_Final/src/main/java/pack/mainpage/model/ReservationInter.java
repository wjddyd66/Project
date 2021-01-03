package pack.mainpage.model;

import java.util.List;

import pack.mainpage.controller.CheckinBean;

public interface ReservationInter {
	List<ReservationDto> reservationList();
	
	int book_upData(CheckinUpdateDto c_updto);
	
	List<CheckinDto> book_selectData(CheckinBean bean);
}
