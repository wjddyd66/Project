package pack.gong.model;

import java.util.HashMap;
import java.util.List;
import org.springframework.dao.DataAccessException;

import pack.gong.controller.gongBean;
import pack.gong.model.gongDto;

public interface gongInter {
	List<gongDto> selectList(HashMap<String, Object> map) throws DataAccessException;
	int Pagesu(HashMap<String, Object> map) throws DataAccessException;
	List<gongDto> selectMain() throws DataAccessException;
	int register(gongBean bean) throws DataAccessException;
	int maxNum() throws DataAccessException;
	gongDto detail(int num) throws DataAccessException;
	int updateNum(int num) throws DataAccessException;
	int delete(int num) throws DataAccessException;
	int updateForm(gongBean bean) throws DataAccessException;
}