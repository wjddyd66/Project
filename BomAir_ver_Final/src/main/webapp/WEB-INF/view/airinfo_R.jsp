<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.0.min.js" ></script>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,900'" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	$('#btnComp').click(function(){
		if($('input:radio[name=radioTxt]').is(':checked') === false ){
			alert("가는편을 선택해주세요")
		}else if($('input:radio[name=radioTxt_R]').is(':checked') === false ){
			alert("오는편을 선택해주세요")
		}else{

		  var result = confirm('정말 예약하시겠습니까?'); 
		  if(result) { 
			$("form:first").submit();			  
		  } else { 
			  location.replace("airinfo"); 			  
		  }

		}
	  });
});
function gogo(start, end, time, a_name, grade){
	
	$('input[name=start]').attr('value', start);
	$('input[name=end]').attr('value', end);
	$('input[name=time]').attr('value', time);
	$('input[name=a_name]').attr('value', a_name);
	$('input[name=grade]').attr('value', grade);
	
	if($('input:radio[name=radioTxt_R]').is(':checked') === false){
		depart();
	}else{
		aa()
	}


} 
	
	/*
		if($('#ap').val() === null || $('#ap').val() === ""){
		alert($('#ap').val());			
		depart();	
		}else{
		aa();			
		}
		*/


function gogo_R(start_R, end_R, time_R, a_name_R, grade_R){
	
	$('input[name=start_R]').attr('value', start_R);
	$('input[name=end_R]').attr('value', end_R);
	$('input[name=time_R]').attr('value', time_R);
	$('input[name=a_name_R]').attr('value', a_name_R);
	$('input[name=grade_R]').attr('value', grade_R);
		
	if($('input:radio[name=radioTxt]').is(':checked') === false){
		alive();
	}else{
		aa()
	}

}


function depart(){
	var air_price = $(":input:radio[name=radioTxt]:checked").val() * ${airbean.people };
	//alert(numberWithCommas(air_price));

	var air_price1 = numberWithCommas(air_price) + " KRW"
	//alert(air_price);
	$('#ap').text(air_price1);
	
	var gong = ${airbean.people * 28600} ;
	var gong1 = numberWithCommas(gong) + " KRW";
	$('#gong').text(gong1);
	
	var you = ${airbean.people * 11800} 
	var you1 = numberWithCommas(you) + " KRW";
	$('#you').text(you1);
	
	var tot = air_price + gong + you;
	var tot1 = numberWithCommas(tot) + " KRW";
	$('#tot').text(tot1);
	
	$('input[name=pay]').attr('value', tot);
}

function alive(){
	var air_price = $(":input:radio[name=radioTxt_R]:checked").val() * ${airbean.people };
	//alert(numberWithCommas(air_price));

	var air_price1 = numberWithCommas(air_price) + " KRW"
	//alert(air_price);
	$('#ap').text(air_price1);
	
	var gong = ${airbean.people * 24200} ;
	var gong1 = numberWithCommas(gong) + " KRW";
	$('#gong').text(gong1);
	
	var you = ${airbean.people * 12100} 
	var you1 = numberWithCommas(you) + " KRW";
	$('#you').text(you1);
	
	var tot = air_price + gong + you;
	var tot1 = numberWithCommas(tot) + " KRW";
	$('#tot').text(tot1);
	
	$('input[name=pay]').attr('value', tot);
}
function aa(){
	
	//라디오버튼 체크 값
	var air_price = $(":input:radio[name=radioTxt]:checked").val() * ${airbean.people };
	var air_price_R = $(":input:radio[name=radioTxt_R]:checked").val() * ${airbean.people };
	
	//원화표시
	var air_price1 = numberWithCommas(air_price) + " KRW"
	var air_price1_R = numberWithCommas(air_price_R) + " KRW"
	
	//왕복 가격
	var tot_price = air_price + air_price_R;
	var tot_price1 = numberWithCommas(tot_price) + " KRW"
	
	$('#ap').text(tot_price1);
	
	//공항이용료
	var gong = ${airbean.people * 52800} ;
	var gong1 = numberWithCommas(gong) + " KRW";
	$('#gong').text(gong1);
	
	//유류세
	var you = ${airbean.people * 23900} 
	var you1 = numberWithCommas(you) + " KRW";
	$('#you').text(you1);
	
	//왕복 공항 유류세 더한값
	var tot = tot_price + gong + you;
	var tot1 = numberWithCommas(tot) + " KRW";
	$('#tot').text(tot1);
	
	$('input[name=pay]').attr('value', tot);
}


function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


</script>
</head>
<body style = "text-align: center; font-family: 'Noto Sans KR', sans-serif;">
<div align="center">
<img class="brand-logo-light" src="resources/images/bomair_logo.png" style="width:510px; height:100px">
<table  rules="none" style="background-color: #7cc67c">
	<tr>
		<td> &nbsp;&nbsp;가는편&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| </td>
		<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;인천 (ICN) ▶  
		<c:choose>
		<c:when test="${airbean.l_code eq 'CJU' }">제주</c:when>
		<c:when test="${airbean.l_code eq 'NPT' }">도쿄</c:when>
		<c:when test="${airbean.l_code eq 'KIX' }">오사카</c:when>
		<c:when test="${airbean.l_code eq 'FUK' }">후쿠오카</c:when>
		<c:when test="${airbean.l_code eq 'HKG' }">홍콩</c:when>
		<c:when test="${airbean.l_code eq 'BKK' }">방콕</c:when>
		<c:when test="${airbean.l_code eq 'BKI' }">코타키나발루</c:when>
		<c:when test="${airbean.l_code eq 'WO' }">블라디보스토크</c:when>
		<c:when test="${airbean.l_code eq 'JFK' }">뉴욕</c:when>
		<c:otherwise> ... </c:otherwise>
		</c:choose>
		(${airbean.l_code })&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;            
		</td>
		<td>${airbean.o_sdate }</td>
	</tr>
	</table>
	



	<br> &nbsp;
	<table >	
	<tr>
		<th>Economy</th><th>Business</th><th>First</th><th>출도착시간</th><th>항공편명</th>
	</tr>
	
	<!-- -------------  편도 -->
	<c:forEach var="a" items="${airinfo }">

	<c:set var="dr">${fn:substring(a.air_name,4,5) % 2}</c:set>
	<c:if test="${dr eq '1' }">
	
		<tr>

			
			<fmt:parseDate var="date_d" value="${a.o_stime }" pattern="HH:mm" />
			<fmt:parseNumber var="date_n" value="${date_d.time + 32400000}" integerOnly="true" />
			<fmt:parseNumber var="date_s" value="${a.o_soyo * 60000}" integerOnly="true" />
			<fmt:parseNumber var="format_hh" value="${(date_n + date_s)/3600000 }" integerOnly="true"/>
			<fmt:parseNumber var="format_mm" value="${(date_n + date_s)%3600000/60000 }" integerOnly="true" />
			<c:choose>
			<c:when test="${format_hh >= 24}">
            <fmt:parseNumber var="soyo_hh" value="${a.o_soyo / 60}" integerOnly="true"/>
            <c:set var="alive" value="${a.o_stime } ~ ${format_hh - 24}:${format_mm } (+1일) <br> (소요시간 : ${soyo_hh }시간 ${a.o_soyo % 60}분)" />
			<c:set var="alive_time" value="${format_hh - 24}:${format_mm } (+1일)"></c:set>
			</c:when>
			
            <c:otherwise>
            <fmt:parseNumber var="soyo_hh" value="${a.o_soyo / 60}" integerOnly="true"/>
            <c:set var="alive" value="${a.o_stime } ~ ${format_hh}:${format_mm } <br> (소요시간 : ${soyo_hh }시간 ${a.o_soyo % 60}분)" />
			<c:set var="alive_time" value="${format_hh }:${format_mm }"></c:set>
            </c:otherwise>
         	</c:choose>
			<c:set var="soyo_time" value="${soyo_hh }시간 ${a.o_soyo % 60}분"></c:set>
			
			
			<td><input type="radio" name="radioTxt" value="${a.o_price }" onclick="javascript:gogo('${a.o_stime }','${alive_time }','${soyo_time }','${a.air_name }','E')"><fmt:formatNumber value="${a.o_price }" pattern="#,###" /> KRW</td>
			<td><input type="radio" name="radioTxt" value="${a.o_price + a.o_price * 0.2 }" onclick="javascript:gogo('${a.o_stime }','${alive_time }','${soyo_time }','${a.air_name }','B')"><fmt:formatNumber value="${a.o_price + a.o_price * 0.2 }" pattern="#,###" /> KRW</td>
			<td><input type="radio" name="radioTxt" value="${a.o_price + a.o_price * 0.9 }" onclick="javascript:gogo('${a.o_stime }','${alive_time }','${soyo_time }','${a.air_name }','F')"><fmt:formatNumber value="${a.o_price + a.o_price * 0.9 }" pattern="#,###" /> KRW</td>

			
			
			<td>${alive }</td>
			<td>${a.air_name }</td>

		</tr>
	</c:if>
	</c:forEach>
</table>
<br>

<hr>
<br>
<!-- 귀국 -->
<table  rules="none" style="background-color: #7cc67c">
	<tr>
		<td> &nbsp;&nbsp;오는편&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| </td>
		<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;  
		<c:choose>
		<c:when test="${airbean.l_code eq 'CJU' }">제주</c:when>
		<c:when test="${airbean.l_code eq 'NPT' }">도쿄</c:when>
		<c:when test="${airbean.l_code eq 'KIX' }">오사카</c:when>
		<c:when test="${airbean.l_code eq 'FUK' }">후쿠오카</c:when>
		<c:when test="${airbean.l_code eq 'HKG' }">홍콩</c:when>
		<c:when test="${airbean.l_code eq 'BKK' }">방콕</c:when>
		<c:when test="${airbean.l_code eq 'BKI' }">코타키나발루</c:when>
		<c:when test="${airbean.l_code eq 'WO' }">블라디보스토크</c:when>
		<c:when test="${airbean.l_code eq 'JFK' }">뉴욕</c:when>
		<c:otherwise> ... </c:otherwise>
		</c:choose>
		(${airbean.l_code }) ▶  인천 (ICN)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;            
		</td>
		<td>${airbean.o_sdate_R } (▦)</td>
	</tr>
	</table>
	



	<br> &nbsp;
	<table >	
	<tr>
		<th>Economy</th><th>Business</th><th>First</th><th>출도착시간</th><th>항공편명</th>
	</tr>
	
	<!-- -------------  왕복 -->
	<c:forEach var="r" items="${airinfo_R }">
	<c:set var="dr_R">${fn:substring(r.air_name,4,5) % 2}</c:set>
	<c:if test="${dr_R eq '0' }">
		<tr>
			<fmt:parseDate var="date_d_R" value="${r.o_stime }" pattern="HH:mm" />
			<fmt:parseNumber var="date_n_R" value="${date_d_R.time + 32400000}" integerOnly="true" />
			<fmt:parseNumber var="date_s_R" value="${r.o_soyo * 60000}" integerOnly="true" />
			<fmt:parseNumber var="format_hh_R" value="${(date_n_R + date_s_R)/3600000 }" integerOnly="true"/>
			<fmt:parseNumber var="format_mm_R" value="${(date_n_R + date_s_R)%3600000/60000 }" integerOnly="true" />
			<c:choose>
			<c:when test="${format_hh_R >= 24}">
            <fmt:parseNumber var="soyo_hh_R" value="${r.o_soyo / 60}" integerOnly="true"/>
            <c:set var="alive_R" value="${r.o_stime } ~ ${format_hh_R - 24}:${format_mm_R } (+1일) <br> (소요시간 : ${soyo_hh_R }시간 ${r.o_soyo % 60}분)" />
			<c:set var="alive_time_R" value="${format_hh_R - 24}:${format_mm_R } (+1일)"></c:set>
			</c:when>
			
            <c:otherwise>
            <fmt:parseNumber var="soyo_hh_R" value="${r.o_soyo / 60}" integerOnly="true"/>
            <c:set var="alive_R" value="${r.o_stime } ~ ${format_hh_R}:${format_mm_R } <br> (소요시간 : ${soyo_hh_R }시간 ${r.o_soyo % 60}분)" />
			<c:set var="alive_time_R" value="${format_hh_R }:${format_mm_R }"></c:set>
            </c:otherwise>
         	</c:choose>
			<c:set var="soyo_time_R" value="${soyo_hh_R }시간 ${r.o_soyo % 60}분"></c:set>
			<td><input type="radio" name="radioTxt_R" value="${r.o_price }" onclick="javascript:gogo_R('${r.o_stime }','${alive_time_R }','${soyo_time_R }','${r.air_name }','E')"><fmt:formatNumber value="${r.o_price }" pattern="#,###" /> KRW</td>
			<td><input type="radio" name="radioTxt_R" value="${r.o_price + r.o_price * 0.2 }" onclick="javascript:gogo_R('${r.o_stime }','${alive_time_R }','${soyo_time_R }','${r.air_name }','B')"><fmt:formatNumber value="${r.o_price + r.o_price * 0.2 }" pattern="#,###" /> KRW</td>
			<td><input type="radio" name="radioTxt_R" value="${r.o_price + r.o_price * 0.9 }" onclick="javascript:gogo_R('${r.o_stime }','${alive_time_R }','${soyo_time_R }','${r.air_name }','F')"><fmt:formatNumber value="${r.o_price + r.o_price * 0.9 }" pattern="#,###" /> KRW</td>

			
			<td>${alive_R }</td>
			<td>${r.air_name }</td>
		</tr>
	</c:if>
	</c:forEach>
</table>
<br>

<!-- --인원/가격 ----------- -->
<div>
<br>
<table  style="text-align: center;">
<tr>
	<td colspan="4" style="text-align: left" >성인 </td>
	<td style="text-align: right" >${airbean.people }명 </td>
</tr>
<tr>
	<td colspan="4" style="text-align: left" >항공운임 </td>
	<td style="text-align: right" id="ap"></td>
</tr>
<tr>
	<td colspan="4" style="text-align: left" >공항사용료</td>
	<td style="text-align: right" id="gong" ></td>
</tr>
<tr>
	<td colspan="4" style="text-align: left" >유류할증료</td>
	<td style="text-align: right" id="you" ></td>
</tr>
<tr>
</tr>
<tr>
	<td>예상 결제 금액 : </td>
	<td colspan="4" style="text-align: right; color: blue" id="tot"></td>
</tr>
</table>
</div>
<br>
<br>
<b style="color: red">▷ 항공권의 운임 및 잔여 좌석수는 실시간 변동될 수 있습니다.</b><br>
▷ 해당 항공 스케줄은 정부인가 조건에 따라 예고없이 변경될 수 있습니다.<br>
<div>
<br>
▣ 유의사항
☞ 이용안내 유류할증료와 공항시설사용료 및 기타수수료는 환율 및 발권일에 따라 변동될 수 있습니다.
☞ 공항시설사용료 및 각종 세금은 노선에 따라 별도 부과될 수 있습니다.
☞ 소아·유아 운임은 홈페이지 - 서비스 안내 - 항공권서비스 - 국제선 운임/국내선 운임 에서 확인하실 수 있습니다.
☞ 무료 기내휴대수하물 허용량은 7kg이며, 자세한 사항은 홈페이지 서비스안내-공항서비스-수하물서비스 에서 확인하실 수 있습니다.
☞ 왕복 항공권 구매 후 여정변경 시 가는 날이 오는 날보다 먼저 이어야 합니다.
☞ 타 항공사로 환승하실 경우, 해당 공항에서 위탁수하물을 수취한 후 다시 출입국 수속을 진행하여 주시기 바랍니다.
</div>
</div>


<form action="complete_R" method="post">
<!-- 가는편 -->
<input type="hidden" name="l_code" value="${airbean.l_code }">
<input type="hidden" name="o_sdate" value="${airbean.o_sdate }">
<input type="hidden" name="people" value="${airbean.people }">
<input type="hidden" name="pay">

<input type="hidden" name="start">
<input type="hidden" name="end">
<input type="hidden" name="time">
<input type="hidden" name="a_name">
<input type="hidden" name="grade">
<input type="hidden" name="maxT" value="${num + 1}">

<!-- 오는편 -->
<input type="hidden" name="o_sdate_R" value="${airbean.o_sdate_R }">
<!-- 
<input type="hidden" name="pay_R">
 -->
<input type="hidden" name="start_R">
<input type="hidden" name="end_R">
<input type="hidden" name="time_R">
<input type="hidden" name="a_name_R">
<input type="hidden" name="grade_R">
<input type="hidden" name="g_id" value="${id}">

</form>
<input type="button" id="btnComp" value="예약하기">
<a href="goindex"><input type="button" id="redirect:/index.jsp" value="취소" ></a>

</body>
</html>