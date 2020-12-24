package pack.mainpage.model;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import pack.mainpage.controller.CheckinBean;

@Repository("reservationImpl")
public class ReservationImpl extends SqlSessionDaoSupport implements ReservationInter {
	public ReservationImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}
	
	public List<ReservationDto> reservationList() {
		return getSqlSession().selectList("selectDepart");
	}
	
	public int book_upData(CheckinUpdateDto dto) {
		int res=getSqlSession().update("book_upData", dto);
		return res;
	}

	public List<CheckinDto> book_selectData(CheckinBean bean) {
		List<CheckinDto> list=getSqlSession().selectList("book_selectData", bean);
		return list;
	}
}
