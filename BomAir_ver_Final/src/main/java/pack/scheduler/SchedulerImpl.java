package pack.scheduler;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("schedulerImpl")

public class SchedulerImpl extends SqlSessionDaoSupport implements SchedulerInter {

	@Autowired
	public SchedulerImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}

	public boolean DailyDelete(String tname) {
		try {
			if (getSqlSession().delete("DailyDelete", tname) == 0) {
				return false;
			} else
				return true;
		} catch (Exception e) {
			System.out.println("DailyDelete err : " + e);
			return false;
		}
	}

	public boolean DailyDelete2(String tname) {
		try {
			if (getSqlSession().delete("DailyDelete2", tname) == 0) {
				return false;
			} else
				return true;
		} catch (Exception e) {
			System.out.println("DailyDelete err : " + e);
			return false;
		}
	}
//	public int CreateTables() {
//		HashMap map = new HashMap();
//		int cnt = 0;
//		for (int i = 1; i <= 9; i++) {
//			for (int j = 1; j <= 9; j++) {
//				for (char add = 65; add <= 68; add++) {
//					String sql = "create table BA";
//					sql += i + "0" + j + add;
//					sql += "(s_no varchar(10) not null, t_no varchar(20) not null, b_name varchar(20) not null, b_pp varchar(20) not null, g_id varchar(20) not null) charset=utf8";
//					map.put("sql", sql);
//					cnt += getSqlSession().insert("createTables", map);
//				}
//			}
//		}
//		return cnt;
//	}
//	
//	public int insertintoTables() {
//		int cnt = 0;
//		for (int i = 1; i <= 9; i++) {
//			for (int j = 1; j <= 9; j++) {
//				for (char add = 65; add <= 68; add++) {
//					String sql = "BA";
//					sql += i + "0" + j + add;
//					cnt += getSqlSession().insert("insertintoTables", sql);
//				}
//			}
//		}
//		return cnt;
//	}
}
