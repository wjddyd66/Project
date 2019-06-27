package pack.guest.model;

public interface LoginInter {
	
	// 로그인 관련 interface
	
	// 로그인 시, 존재하는 아이디인지 체크
	public boolean loginCheck(String userInputId, String userInputPwd); 
}
