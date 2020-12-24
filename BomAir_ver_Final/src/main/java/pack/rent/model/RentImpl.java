package pack.rent.model;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pack.guest.controller.GuestBean;

@Repository("rentImpl")
public class RentImpl extends SqlSessionDaoSupport implements RentInter{
	
	@Autowired
	public RentImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}
	
	public List<RentDto> RentDataAll(HashMap<String,Object> map) {
		return getSqlSession().selectList("rentAllData",map);
	}
	
	public boolean submitRent(HashMap<String,Object> map) {
		boolean b = false;
		
		if(getSqlSession().insert("submitRent",map) > 0 ) {
			b = true;
		}
		return b;
	}
	
	public List<RentDto> RentDataAll2(String RentPlaceTd) {
		return getSqlSession().selectList("rentAllData2",RentPlaceTd);
	}
	
	public List<RentDto> MyRentPage(String g_id) {
		return getSqlSession().selectList("myCarPage",g_id);
	}
	
	public List<RentDto> AdminCar() {
		return getSqlSession().selectList("admincarPage");
	}
	
	public boolean DeleteRent(HashMap<String,Object> map) {
		boolean b= false;
		if(getSqlSession().delete("deleteRent",map) > 0 ) {
			b = true;
		}
		return b;
	}	
	
	public boolean InsertCar(HashMap<String, Object> map) {
		boolean b= false;
		if(getSqlSession().insert("insertCar",map) > 0 ) {
			b = true;
		}
		return b;
	}
	
	public List<RentDto> CarAll() {
		return getSqlSession().selectList("carAll");
	}
	
	public boolean DeleteCar(String r_no) {
		System.out.println("Check1"+r_no);
		boolean b= false;
		if(getSqlSession().delete("deleteCar",r_no) > 0 ) {
			b = true;
		}
		return b;
	}
	
	public boolean deleteCarRent(String r_no) {
		System.out.println("Check2"+r_no);
		boolean b= false;
		if(getSqlSession().delete("deleteCarRent",r_no) > 0 ) {
			b = true;
		}
		return b;	}
}
