<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my Ticket</title>
<script
	src='https://static.codepen.io/assets/editor/live/console_runner-1df7d3399bdc1f40995a35209755dcfd8c7547da127f6469fd81e5fba982f6af.js'></script>
<script
	src='https://static.codepen.io/assets/editor/live/css_reload-5619dc0905a68b2e6298901de54f73cefe4e079f65a75406858d92924b4938bf.js'></script>
<meta charset='UTF-8'>
<meta name="robots" content="noindex">
<link rel="shortcut icon" type="image/x-icon"
	href="https://static.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" />
<link rel="mask-icon" type=""
	href="https://static.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg"
	color="#111" />
<link rel="canonical" href="https://codepen.io/victorjanin/pen/oGYvjK" />
<link rel="stylesheet" href="resources/css/ticketstyle.css" />

<script type="text/javascript">

function pagePrintPreview(){
    var browser = navigator.userAgent.toLowerCase();
    if ( -1 != browser.indexOf('chrome') ){
               window.print();
    }else if ( -1 != browser.indexOf('trident') ){
               try{
                        //참고로 IE 5.5 이상에서만 동작함
                        //웹 브라우저 컨트롤 생성
                        var webBrowser = '<OBJECT ID="previewWeb" WIDTH=0 HEIGHT=0 PORTRAIT=TRUE CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
                        //웹 페이지에 객체 삽입
                        document.body.insertAdjacentHTML('beforeEnd', webBrowser);
                        //ExexWB 메쏘드 실행 (7 : 미리보기 , 8 : 페이지 설정 , 6 : 인쇄하기(대화상자))
                        previewWeb.ExecWB(7, 1);
                        //객체 해제
                        previewWeb.outerHTML = "";
               }catch (e) {
                        alert("- 도구 > 인터넷 옵션 > 보안 탭 > 신뢰할 수 있는 사이트 선택\n   1. 사이트 버튼 클릭 > 사이트 추가\n   2. 사용자 지정 수준 클릭 > 스크립팅하기 안전하지 않은 것으로 표시된 ActiveX 컨트롤 (사용)으로 체크\n\n※ 위 설정은 프린트 기능을 사용하기 위함임");
               }
            
    }
    
}

function Email_ticket(t_no){
	   $('input[name=t_no]').attr('value', t_no);
	   var o_sdate = t_no.substring(1,5) + "-" + t_no.substring(5,7) + "-" + t_no.substring(7,9);
	   //alert(o_sdate);
	   $('input[name=o_sdate]').attr('value', o_sdate);
	   
	   $('#email').submit();

}
</script>
</head>
<body>
<br>
<br><br>
<div style="text-align: center;width: 800px;" >
bomair ticket 미리보기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="pagePrintPreview()" value="프린트하기">
<input type="button" onclick="Email_ticket('${dto.t_no}')" value="내메일로 받기">
</div>
<br>
<br>
<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;

	<main> 
	
	<header>
		<h1>Boarding pass BOMAIR</h1>
		<div>
			<h5>Flight n°</h5>
			<p>${dto.air_name }</p>
		</div>
		<div>
			<h5>Passengers</h5>
			<p style="text-align: center;">${fn:substring(dto.t_no,11,12)}</p>
		</div>
	</header>

	<section class="flight--general">
	<c:if test="${fn:substring(dto.t_no ,0,1) eq 'D'}">
		<div>
			<h4>출발 도시</h4>
			<h2>ICN</h2>
		</div>
		<div>
			<h4>to</h4>
		</div>
		<div>
			<h4>도착 도시</h4>
			
			<h2>
			<c:choose>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '1'}">CJU</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '2'}">NPT</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '3'}">KIX</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '4'}">FUK</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '5'}">HKG</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '6'}">BKK</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '7'}">BKI</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '8'}">WO</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '9'}">JFK</c:when>			
			</c:choose>
			</h2>
		</div>
		</c:if>
		
			<c:if test="${fn:substring(dto.t_no ,0,1) eq 'R'}">
		<div>
			<h4>출발 도시</h4>
			<h2>
			<c:choose>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '1'}">CJU</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '2'}">NPT</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '3'}">KIX</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '4'}">FUK</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '5'}">HKG</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '6'}">BKK</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '7'}">BKI</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '8'}">WO</c:when>
				<c:when test="${fn:substring(dto.air_name,2,3) eq '9'}">JFK</c:when>			
			</c:choose>
			</h2>
		</div>
		<div>
			<h4>to</h4>
		</div>
		<div>
			<h4>도착 도시</h4>
			<h2>ICN</h2>
			
		</div>
		</c:if>
	</section>
	<section class="flight--TimeInfo" style="width: 295px;">
		<br>
		<div>
			<h5>Boarding</h5><br>
			<p style="text-align: center;">${fn:split(dto.o_stime,':')[0] - 1}:${fn:split(dto.o_stime,':')[1] + 20}</p>
		</div>
		<div>
			<h5>Departure</h5><br>
			<p style="text-align: center;">${dto.o_stime }</p>
		</div>
		<div>
			<h5 style="text-align: center;">Date</h5><br>
			<p style="text-align: center;">${dto.o_sdate }</p>
		</div>
	</section>
	<section class="flight--PassInfo" style="width: 295px; padding-top: 0">
		<div>
			<h5>Passenger</h5><br>
			<c:set var="peo" value="${fn:substring(dto.t_no,11,12)}"/>
			<c:if test="${peo eq '1'}">
			<p>${dto.g_id }</p>			
			</c:if>
			<c:if test="${peo ne '1'}">			
			<p>${dto.g_id }외 ${fn:substring(dto.t_no,11,12)-1}명</p>
			</c:if>
		</div>
		<div>
			<h5>Seat</h5><br>
			<p>${dto.s_no }</p>
		</div>
	</section>
	<section class="flight--qrcode" style="margin-left: 75px; width: 175px;">
		<img src="https://cdnqrcgde.s3-eu-west-1.amazonaws.com/wp-content/uploads/2013/11/jpeg.jpg" style="width: 130px; height: 130px">
	</section>

	</main>

	<script src='https://static.codepen.io/assets/common/stopExecutionOnTimeout-de7e2ef6bfefd24b79a3f68b414b87b8db5b08439cac3f1012092b2290c719cd.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>

	<form action="Email_ticket" method="post" id="email">
   <input type="hidden" name="t_no">
   <input type="hidden" name="o_sdate">
   </form>

</body>
</html>