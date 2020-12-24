package pack.mail.controller;

import java.io.File;
import java.util.HashMap;

import javax.mail.internet.MimeMessage;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import pack.model.BookDto;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

@Component
public class EmailSender extends SqlSessionDaoSupport {

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	public EmailSender(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}

	public HashMap<String, Object> getMailAddress(String id) throws DataAccessException {
		return getSqlSession().selectOne("Mail_Address", id);
	}

	public HashMap<String, Object> getMail_Pwd(HashMap<String, Object> map) throws DataAccessException {
		return getSqlSession().selectOne("Mail_Pwd", map);
	}

	public void sendEmail(BookDto dto) throws Exception {
		// 메일 발송 기능 제공
		HashMap<String, Object> map = getMailAddress(dto.getG_id());
		String setfrom = "hwangjeongyong4@gmail.com";
		String tomail = (String) map.get("g_mail"); // 받는 사람 이메일
		String title = "BOM AIR 이용을 감사드립니다"; // 제목

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			String text = Sum_Content(dto);
			messageHelper.setText(text, true);
			FileSystemResource file = new FileSystemResource(
					new File("C:/Users/KITCOOP/Desktop/BomAir_ver_01-1/src/main/webapp/resources/images/logo.png"));

			FileSystemResource file2 = new FileSystemResource(
					new File("C:/Users/KITCOOP/Desktop/BomAir_ver_01-1/src/main/webapp/resources/images/facebook.png"));
			FileSystemResource file3 = new FileSystemResource(
					new File("C:/Users/KITCOOP/Desktop/BomAir_ver_01-1/src/main/webapp/resources/images/twitter.png"));

			messageHelper.addInline("logo.png", file);
			messageHelper.addInline("facebook.png", file2);
			messageHelper.addInline("twitter.png", file3);
			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public boolean sendPwd(HashMap<String, Object> paramap) {
		boolean b = false;
		HashMap<String, Object> map = getMail_Pwd(paramap);
		if (map.size() != 0) {
			b = true;
			String setfrom = "hwangjeongyong4@gmail.com";
			String tomail = (String) map.get("g_mail"); // 받는 사람 이메일
			String title = "BOM AIR 비밀번호 찾기 기능 입니다."; // 제목
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				messageHelper.setFrom(setfrom); // 보내는사람 생략하거나 하면 정상작동을 안함
				messageHelper.setTo(tomail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				String text = "고객님의 비밀번호는 " + (String) map.get("g_pwd");
				messageHelper.setText(text, true);
				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}

		}
		return b;
	}

	public String Sum_Content(BookDto dto) {
		StringBuffer sb = new StringBuffer();
		sb.append("<html>");
		sb.append("<head>");
		sb.append("<meta charset='UTF-8'>");
		sb.append("<title>Insert title heresb.append</title>");
		sb.append("</head>");
		sb.append("<body>");
		sb.append("<table align='center' border='1' cellpadding='0' cellspacing='0' width='600'>");
		sb.append("<tr>");
		sb.append("<td align='center' style='padding: 40px 0 30px 0;'>");
		sb.append(
				"<img src=\"cid:logo.png\" alt='Creating Email Magic' width='300' height='80' style='display: block;' />");
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td bgcolor='#ffffff' style='padding: 40px 30px 40px 30px;'>");
		sb.append("<table cellpadding='0' cellspacing='0' width='100%'>");
		sb.append("<tr style='text-align: center;'>");
		sb.append("<td>BOM AIR 이용 감사합니다!</td>");
		sb.append("</tr>");
		sb.append("<tr>");

		sb.append("<td style='text-align: center;'>");
		sb.append("<table border='1' style='margin-left: 170px;'>");
		sb.append("<tbody>");
		sb.append("<tr>");
		sb.append("<th align='center' colspan='2'>상세 예약정보</th>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td align='center'>예매자</td>");
		sb.append("<td align='center'>"+dto.getG_id()+"</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td align='center'>인원 수</td>");
		sb.append("<td align='center'>"+dto.getT_no().substring(11, 12)+"명</td>");
		sb.append("</tr>");

		sb.append("<tr>");
		sb.append("<td align='center'>출발지</td>");
		sb.append("<td align='center'>인천(ICN)</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td align='center'>도착지</td>");
		sb.append("<td align='center'>"+for_DepartmentPlace(dto.getAir_name().substring(2, 3))+"</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td align='center'>출발날짜</td>");
		sb.append("<td align='center'>"+dto.getT_no().substring(1, 5)+"-"+dto.getT_no().substring(5, 7)+"-"+dto.getT_no().substring(7,9)+"</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td align='center'>출발시간</td>");
		sb.append("<td align='center'>"+dto.getO_stime()+"</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td align='center'>소요시간</td>");
		sb.append("<td align='center'>"+for_time(dto.getO_soyo())+"</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td align='center'>편명</td>");
		sb.append("<td align='center'>"+dto.getAir_name()+"</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td align='center'>예약한 날짜</td>");
		sb.append("<td align='center'>"+dto.getAb_date()+"</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td align='center'>결제가격</td>");
		sb.append("<td align='center'>"+dto.getPay()+" KRW</td>");
		sb.append("</tr>");

		sb.append("<tr>");
		sb.append("<td align='center'>좌석번호</td>");
		sb.append("<td align='center'>나중에 추가</td>");
		sb.append("</tr>");
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</td>");

		sb.append("</tr>");

		sb.append("</table>");
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("<td style='padding: 30px 30px 30px 30px;'>");
		sb.append("<table cellpadding='0' cellspacing='0' width='100%'>");
		sb.append("<tr>");
		sb.append("<td width='75%'> 세계 최고를 향하는 국민항공<br/>BOMAIR 2019 항공여행 대중화를 창조하겠습니다.");
		sb.append("</td>");
		sb.append("<td>");
		sb.append("<a href='http://www.twitter.com/'>");
		sb.append(
				"<img src=\"cid:twitter.png\" alt='Twitter' width='38' height='38' style='display: block;' border='0' />");
		sb.append("</a>");
		sb.append("</td>");
		sb.append("<td>");
		sb.append("<a href='http://www.twitter.com/'>");
		sb.append(
				"<img src=\"cid:facebook.png\" alt='Facebook' width='38' height='38' style='display: block;' border='0' />");
		sb.append("</a>");
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</table>");
		sb.append("</td>");
		sb.append("</tr>");
		sb.append("</table>");
		sb.append("</body>");
		sb.append("</html>");
		return sb.toString();
	}
	
	public String for_time(String tt) {
		int x = Integer.parseInt(tt);
		String s=x/60+"시간"+x%60+"분";
		return s;
	}
	
	public String for_DepartmentPlace(String dd) {
		String s="";
		if(dd.equals("1"))
			s="제주(CJU)";
		else if(dd.equals("2"))
			s="도쿄(NPT)";
		else if(dd.equals("3"))
			s="오사카(KIX)";
		else if(dd.equals("4"))
			s="후쿠오카(FUK)";
		else if(dd.equals("5"))
			s="홍콩(HKG)";
		else if(dd.equals("6"))
			s="방콩(BKK)";
		else if(dd.equals("7"))
			s="코타키나발루(BKI)";
		else if(dd.equals("8"))
			s="블라디보스토크(WO)";
		else if(dd.equals("9"))
			s="뉴욕(JFK)";
		return s;
	}
}
