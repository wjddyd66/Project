package pack.scheduler;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import pack.scheduler.SchedulerInter;

@Component
public class Scheduler {




	@Autowired
	private SchedulerInter inter;

	@Scheduled(cron = "0 0 3 * * *")
	public void DeleteTableADaily() {
		Date today = new Date();
		System.out.println("현재 시간 : " + today);
		System.out.println("스케줄러 실행 - 이륙 날짜가 전 날인 노선 삭제");
		String tname = "<CURDATE()";
		inter.DailyDelete(tname);
	}

	@Scheduled(cron = "0 0 4 * * *")
	public void DeleteTableADaily2() {
		Date today = new Date();
	    System.out.println("현재 시간 : " + today);
		System.out.println("스케줄러 실행 - 전날 비행기 객석 정보 삭제");
		for(int i=1;i<=9;i++) {
			for(int j=1;j<=9;j++) {
				String sql="delete from ba"+i+"0"+j+" where STR_TO_DATE(substring(t_no,2,8),'%Y%m%d') < CURDATE()";
				String sql2="delete from ba"+i+"0"+j+"a where STR_TO_DATE(substring(t_no,2,8),'%Y%m%d') < CURDATE()";
				String sql3="delete from ba"+i+"0"+j+"b where STR_TO_DATE(substring(t_no,2,8),'%Y%m%d') < CURDATE()";
				String sql4="delete from ba"+i+"0"+j+"c where STR_TO_DATE(substring(t_no,2,8),'%Y%m%d') < CURDATE()";
				String sql5="delete from ba"+i+"0"+j+"d where STR_TO_DATE(substring(t_no,2,8),'%Y%m%d') < CURDATE()";
				inter.DailyDelete2(sql);
				inter.DailyDelete2(sql2);
				inter.DailyDelete2(sql3);
				inter.DailyDelete2(sql4);
				inter.DailyDelete2(sql5);
			}
		}
	}
}