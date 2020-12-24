package pack.guest.model;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pack.guest.controller.GuestBean;

@Repository("guestInterImpl")
public class GuestInterImpl extends SqlSessionDaoSupport implements GuestInter {

	@Autowired
	public GuestInterImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}

	public boolean insData(GuestBean bean) {
		try {
			getSqlSession().insert("register_insertData", bean);
			return true;
		} catch (Exception e) {
			System.out.println("reg_insData err" + e);
			return false;
		}
	}

	public GuestDto selectData(String g_id) {
		GuestDto dto = getSqlSession().selectOne("mypage_selectData", g_id);
		return dto;
	}

	public boolean upData(GuestBean bean) {
		  int res=getSqlSession().update("mypage_upData", bean);
		  if(res>0) {
			  return true;
		  } else  return false;
	}
	
	public boolean delData(String g_id) {
		int re=getSqlSession().delete("mypage_delData", g_id);
		if(re>0) {
			return true;
		} else return false;
	}

	public int idCheck(String id) {
		try {
			int id_check = 0;
			id_check = getSqlSession().selectOne("register_checkId", id);
			return id_check;
		} catch (Exception e) {
			System.out.println("reg_insData err" + e);
			return -1;
		}
	}

	public List<HashMap<String, Object>> find_id(HashMap<String, Object> map) {
		System.out.println((String) map.get("g_name") + (String) map.get("g_tel"));
		return getSqlSession().selectList("register_findid", map);
	}

}
