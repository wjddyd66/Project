<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bomair 예매내역 상세보기</title>
<link rel="stylesheet" type="text/css" href="resources/css/style.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.0.min.js" ></script>
<link rel="stylesheet" href="resources/css/detail.css">
<script type="text/javascript">
function functview(t_no, s_no) {

	if(s_no === '' || s_no === null){
		alert("체크인 후 이용 가능합니다");
	}else {
		
	$('input[name=t_no]').attr('value', t_no);
	var o_sdate = t_no.substring(1,5) + "-" + t_no.substring(5,7) + "-" + t_no.substring(7,9);
	$('input[name=o_sdate]').attr('value', o_sdate);
	$('#tview').submit();
	}
}

function pagePrintPreview(){
    var browser = navigator.userAgent.toLowerCase();
    if ( -1 != browser.indexOf('chrome') ){
               window.print();
    }else if ( -1 != browser.indexOf('trident') ){
               try{
                        //참고로 IE 5.5 이상에서만 동작함
                        //웹 브라우저 컨트롤 생성
                        var webBrowser = '<OBJECT ID="previewWeb" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
                        //웹 페이지에 객체 삽입
                        document.body.insertAdjacentHTML('beforeEnd', webBrowser);
                        //ExexWB 메쏘드 실행 (7 : 미리보기 , 8 : 페이지 설정 , 6 : 인쇄하기(대화상자))
                        previewWeb.ExecWB(7, 1);
                        //객체 해제
                        previewWeb.outerHTML = "./resources/param.html";
               }catch (e) {
                        alert("- 도구 > 인터넷 옵션 > 보안 탭 > 신뢰할 수 있는 사이트 선택\n   1. 사이트 버튼 클릭 > 사이트 추가\n   2. 사용자 지정 수준 클릭 > 스크립팅하기 안전하지 않은 것으로 표시된 ActiveX 컨트롤 (사용)으로 체크\n\n※ 위 설정은 프린트 기능을 사용하기 위함임");
               }
            
    }
    
}

function airinfo() {
	location.href = "airinfo";
}
</script>

</head>
<body class="basicFont container">
<div class="logo"><a href="index.jsp"><img src="resources/images/bomair_logo.png"/></a></div>
<h1>예약번호 : ${dto.t_no }</h1>
<br>
<input type="button" class="btn btn-primary nextBtn btn-lg btn2 btn2-lg" value="나의예매" onclick="history.back(-1)">&nbsp;
<!-- <input type="button" class="btn btn-primary nextBtn btn-lg btn2 btn2-lg" value="예약하기" onclick="javascript:airinfo()"> -->

<hr class="hrCss">
<br>
<table>
<tr>
<th align="center" colspan="2">상세 예약정보</th>
</tr>
<tr>
	<td align="center">예매자</td>
	<td align="center">${dto.g_id }</td>
</tr>
<tr>
	<td align="center">인원 수</td>
	<td align="center">
	${fn:substring(dto.t_no ,11,12)} 명

	</td>
</tr>
		<c:if test="${fn:substring(dto.t_no ,0,1) eq 'D'}">
<tr>
	<td align="center">출발지</td>
	<td align="center">인천(ICN)</td>
</tr>
<tr>
	<td align="center">도착지</td>
	<td align="center">
			<c:choose>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '1'}">제주(CJU)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '2'}">도쿄(NPT)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '3'}">오사카(KIX)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '4'}">후쿠오카(FUK)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '5'}">홍콩(HKG)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '6'}">방콕(BKK)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '7'}">코타키나발루(BKI)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '8'}">블라디보스토크(WO)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '9'}">뉴욕(JFK)</c:when>			
			</c:choose>
		</td>
		</tr>
		</c:if>

		<c:if test="${fn:substring(dto.t_no ,0,1) eq 'R'}">
<tr>
	<td align="center">출발지</td>
	<td align="center">
	<c:choose>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '1'}">제주(CJU)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '2'}">도쿄(NPT)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '3'}">오사카(KIX)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '4'}">후쿠오카(FUK)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '5'}">홍콩(HKG)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '6'}">방콕(BKK)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '7'}">코타키나발루(BKI)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '8'}">블라디보스토크(WO)</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '9'}">뉴욕(JFK)</c:when>			
			</c:choose>
	</td>
</tr>
<tr>
	<td align="center">도착지</td>
	<td align="center">인천(ICN)</td>
		</tr>
</c:if>


<tr>
	<td align="center">출발날짜</td>
	<td align="center">${fn:substring(dto.t_no ,1,5)}-${fn:substring(dto.t_no ,5,7)}-${fn:substring(dto.t_no ,7,9)}</td>
</tr>
<tr>
	<td align="center">출발시간</td>
	<td align="center">${dto.o_stime }</td>
</tr>
<tr>
	<td align="center">소요시간</td>
	<td align="center">
	<fmt:parseNumber var="soyo_hh" value="${dto.o_soyo / 60}" integerOnly="true"/>
	<c:set var="soyo_time" value="${soyo_hh }시간 ${dto.o_soyo % 60}분"></c:set>
	${soyo_time }
	</td></tr>
<tr>
	<td align="center">편명</td>
	<td align="center">${dto.air_name }</td>
</tr>
<tr>
	<td align="center">예약한 날짜</td>
	<td align="center">${dto.ab_date }</td>
</tr>
<tr>
	<td align="center">결제가격</td>
	<td align="center"><fmt:formatNumber value="${dto.pay }" pattern="#,###" /> KRW</td>
</tr>

<tr>
	<td align="center">좌석번호</td>
	<c:choose>
	<c:when test="${dto.s_no eq null}">
	<td align="center">
	<input type="button" value="체크인" onclick = "javascript:checkIn('${dto.t_no }')">
	</td>
	</c:when>
	<c:otherwise>
		<td align="center">
		${dto.s_no}
		</td>
		</c:otherwise>
	</c:choose>
</tr>
</table>
<br><br>

<a href="javascript:functview('${dto.t_no }', '${dto.s_no}')"  target="f_main">티켓미리보기</a> &nbsp;&nbsp;&nbsp;&nbsp;

<input type="button" value="결제 내역 프린트하기" onclick="javascrpit:pagePrintPreview()">
<hr>
<br>


<iframe name="f_main" id="f_main" width="90%" height="500px" class="myFrame"></iframe>

<br>
<hr>
<br>

	<form action="tview" method="post" id="tview" target="f_main">
	<input type="hidden" name="t_no">
	<input type="hidden" name="o_sdate">
	</form>



</body>
</html>