package pack.guest.model;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("loginImpl")
public class LoginImpl extends SqlSessionDaoSupport implements LoginInter{
	
	@Autowired
	public LoginImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}
	
	public boolean loginCheck(String userInputId, String userInputPwd) {
		boolean res=false; // 결과 리턴 할 상태값 (로그인 실패시: false 리턴)
		try {
			System.out.println(userInputId+userInputPwd);
			/*
			System.out.println("userInputId: "+userInputId+", userInputPwd: "+userInputPwd);
			System.out.println(getSqlSession().selectOne("login_LoginCheck", userInputId));
			*/
			String g_pwd=getSqlSession().selectOne("login_LoginCheck", userInputId);

			System.out.println(g_pwd);
			
			if(g_pwd.equals(userInputPwd)) {
				res=true;
			}
		} catch (Exception e) {
			System.out.println("loginCheck err: "+e);
		}
		return res;
	}
}
