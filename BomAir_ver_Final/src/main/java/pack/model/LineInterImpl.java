package pack.model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pack.controller.BookBean;
import pack.controller.CompleteBean;
import pack.controller.LineBean;

@Repository
public class LineInterImpl extends SqlSessionDaoSupport implements LineInter{
	
	@Autowired
	public LineInterImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}
	
	public List<LineDto> getDataAll() {
		return getSqlSession().selectList("selectDataAll");
	}
	
	public LineDto selectPart(String num) {
		return getSqlSession().selectOne("selectPart",num);
	}
	
	//-------------------날짜와 코드 입력시 항공정보 출력----------------
	public List<LineDto> DatePart(LineBean bean) {
		return getSqlSession().selectList("datePart", bean);
	}
	
	public List<LineDto> DatePart_R(LineBean bean) {
		return getSqlSession().selectList("datePart_R", bean);
	}
	
	//------------------------ 여기서부터 항공정보 insert------------------------------
	public boolean insData(LineBean bean) {
//		System.out.println(bean.getL_code());
		try {
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				
				Date date = df.parse(bean.getO_sdate());
				Calendar cal = Calendar.getInstance();
				// 날짜 더하기
				cal.setTime(date);
				bean.setO_sdate(df.format(cal.getTime()));
				
				int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				//System.out.println(bean.getO_sdate());
				//System.out.println(endDay);	
				
				if(bean.getL_code().equals("CJU")) {
				for (int i = 0; i < endDay; i++) {
					bean.setO_sdate(df.format(cal.getTime()));

					for (int j = 1; j < 10; j++) {
						bean.setAir_name("BA" + Integer.toString(100+j));
						bean.setO_stime(Integer.toString(3+j*2) + ":00");
						bean.setO_price(Integer.toString(33000 + j * 1000));
						
						getSqlSession().insert("insertData", bean);
					}
					cal.add(Calendar.DATE, 1);
				}
				 
				
			}else if(bean.getL_code().equals("NPT")) {
				for (int i = 0; i < endDay; i++) {					
					bean.setO_sdate(df.format(cal.getTime()));

					for (int j = 1; j < 10; j++) {
						bean.setAir_name("BA" + Integer.toString(200+j));
						bean.setO_stime(Integer.toString(3+j*2) + ":00");
						bean.setO_price(Integer.toString(60000 + j * 2700));
						
						getSqlSession().insert("insertData", bean);
					}
					cal.add(Calendar.DATE, 1);
				}

			}else if(bean.getL_code().equals("KIX")) {
				for (int i = 0; i < endDay; i++) {					
					bean.setO_sdate(df.format(cal.getTime()));

					for (int j = 1; j < 10; j++) {
						bean.setAir_name("BA" + Integer.toString(300+j));
						bean.setO_stime(Integer.toString(3+j*2) + ":00");
						bean.setO_price(Integer.toString(50000 + j * 2300));
						
						getSqlSession().insert("insertData", bean);
					}
					cal.add(Calendar.DATE, 1);
				}
			}else if(bean.getL_code().equals("FUK")) {
				for (int i = 0; i < endDay; i++) {					
					bean.setO_sdate(df.format(cal.getTime()));

					for (int j = 1; j < 10; j++) {
						bean.setAir_name("BA" + Integer.toString(400+j));
						bean.setO_stime(Integer.toString(3+j*2) + ":00");
						bean.setO_price(Integer.toString(40000 + j * 1800));
						
						getSqlSession().insert("insertData", bean);
					}
					cal.add(Calendar.DATE, 1);
				}
			}else if(bean.getL_code().equals("HKG")) {
				for (int i = 0; i < endDay; i++) {					
					bean.setO_sdate(df.format(cal.getTime()));

					for (int j = 1; j < 10; j++) {
						bean.setAir_name("BA" + Integer.toString(500+j));
						bean.setO_stime(Integer.toString(3+j*2) + ":00");
						bean.setO_price(Integer.toString(120000 + j * 3500));
						
						getSqlSession().insert("insertData", bean);
					}
					cal.add(Calendar.DATE, 1);
				}
			}else if(bean.getL_code().equals("BKK")) {
				for (int i = 0; i < endDay; i++) {					
					bean.setO_sdate(df.format(cal.getTime()));

					for (int j = 1; j < 10; j++) {
						bean.setAir_name("BA" + Integer.toString(600+j));
						bean.setO_stime(Integer.toString(3+j*2) + ":00");
						bean.setO_price(Integer.toString(130000 + j * 2700));
						
						getSqlSession().insert("insertData", bean);
					}
					cal.add(Calendar.DATE, 1);
				}
			}else if(bean.getL_code().equals("BKI")) {
				for (int i = 0; i < endDay; i++) {					
					bean.setO_sdate(df.format(cal.getTime()));

					for (int j = 1; j < 10; j++) {
						bean.setAir_name("BA" + Integer.toString(700+j));
						bean.setO_stime(Integer.toString(3+j*2) + ":00");
						bean.setO_price(Integer.toString(260000 + j * 3600));
						
						getSqlSession().insert("insertData", bean);
					}
					cal.add(Calendar.DATE, 1);
				}
			}else if(bean.getL_code().equals("WO")) {
				for (int i = 0; i < endDay; i++) {					
					bean.setO_sdate(df.format(cal.getTime()));

					for (int j = 1; j < 10; j++) {
						bean.setAir_name("BA" + Integer.toString(800+j));
						bean.setO_stime(Integer.toString(3+j*2) + ":00");
						bean.setO_price(Integer.toString(350000 + j * 3800));
						
						getSqlSession().insert("insertData", bean);
					}
					cal.add(Calendar.DATE, 1);
				}
			}else if(bean.getL_code().equals("JFK")) {
				for (int i = 0; i < endDay; i++) {					
					bean.setO_sdate(df.format(cal.getTime()));

					for (int j = 1; j < 10; j++) {
						bean.setAir_name("BA" + Integer.toString(900+j));
						bean.setO_stime(Integer.toString(3+j*2) + ":00");
						bean.setO_price(Integer.toString(750000 + j * 42500));
						
						getSqlSession().insert("insertData", bean);
					}
					cal.add(Calendar.DATE, 1);
				}
			}
			
			return true;
		}catch (Exception e) {
			System.out.println("insData err : " + e);
			return false;
		}
	}
	//------------------------ 여기까지 항공정보 insert------------------------------
	
	//------------------------ 여기부터 항공예약정보 입력 ------------------------
	/*
	 */
	public String MaxT() {
		String maxT = getSqlSession().selectOne("selectMaxT");
		return maxT;
	}
	
	
	
	public void DepartIns(CompleteBean bean) {
		try {
			
	        String date = bean.getO_sdate();
	        String date1 = date.split("-")[0]+date.split("-")[1]+date.split("-")[2];
	        String t_no="D"+ date1 + "-" + bean.getGrade() + bean.getPeople() + "-" + bean.getMaxT();
			bean.setT_no(t_no);
			
			getSqlSession().insert("departIns", bean);
			
			
		} catch (Exception e) {
			System.out.println("DepartIns err : " + e);
		}

	}
	
	public void DepartIns_R(CompleteBean bean) {
		try {
			
	        String date = bean.getO_sdate_R();
	        String date1 = date.split("-")[0]+date.split("-")[1]+date.split("-")[2];
	        String t_no="R"+ date1 + "-" + bean.getGrade_R() + bean.getPeople() + "-" + bean.getMaxT();
			bean.setT_no(t_no);
			
			getSqlSession().insert("departIns_R", bean);
			
			
		} catch (Exception e) {
			System.out.println("DepartIns err : " + e);
		}

	}
	
	public List<BookDto> myDataAll(String id) {
		String g_id=id;
		return getSqlSession().selectList("bookDataPart",g_id);
	}
	
	public BookDto detailPart(BookBean bean) {
		
		return getSqlSession().selectOne("detailPart", bean);
	}

	
	public HashMap<String, Object> detailName(String g_id) {
		return getSqlSession().selectOne("detaiName", g_id);
	}
	
	//sales-----------------------------------------
	public List<BookDto> SalesDataAll() {
		
		return getSqlSession().selectList("salesDataAll");
	}
	public List<BookDto> Datepay() {
		return getSqlSession().selectList("Datepay");
	}
	
	public List<BookDto> DatepayPart(String ad_date) {
		return getSqlSession().selectList("DatepayPart", ad_date);
	}
}
