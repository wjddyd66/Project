<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<%
	String g_id = (String) session.getAttribute("id");
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bom Air : 나의 예약정보 조회</title>
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.4.0.js"
  integrity="sha256-DYZMCC8HTC+QDr5QNaIcfR7VSPtcISykd+6eSmBW5qo=" crossorigin="anonymous"></script>
<!-- 직접 정의한 CSS -->
<link rel="stylesheet" href="resources/css/mybook.css">
<script type="text/javascript">
// <c:set var = "inwon" value = "${fn:substring(my.t_no, 11, 1)}" />
/*
$(function(){
	$("#btnGoCheckIn").click(function(){
		console.log('${fn:substring(my.t_no, 11, 1)}');
		console.log('${my.air_name}');
		$("#inwon").val(${fn:substring(my.t_no, 11, 1)});
		$("#a_seat").val(${my.air_name});
		$("form[name=frm]").submit();
	})
})
*/

function goCheckIn(t_no, air_name){
	console.log(t_no.substring(11,12));
	console.log(air_name);
	$("#t_no").val(t_no);
	$("#inwon").val(t_no.substring(11,12));
	$("#a_seat").val(air_name);
	$("form[name=frm]").submit();
}

function funcdetail(t_no) {
	   $('input[name=t_no]').attr('value', t_no);
	   var o_sdate = t_no.substring(1,5) + "-" + t_no.substring(5,7) + "-" + t_no.substring(7,9);
	   // alert(o_sdate);
	   $('input[name=o_sdate]').attr('value', o_sdate);
	   
	   $('#detail').submit();
}

</script> 
</head>
<body>
	
	<!-- 
	<c:if test="${id eq null }">
		<c:redirect url="login"/>
	</c:if>
	-->
	
	<div class="container">
		<div class="logo"><a href="index.jsp"><img src="resources/images/bomair_logo.png"/></a></div>
		<h1>나의 항공예약 정보조회</h1>
		<h4><%=g_id %>님의 항공예약 내역입니다.</h4>
		<hr class="hrCss">
		<br>
		
		<div class="webCheckInArea basicFont">
			
			<c:set var="mybook" value="${mybook }"></c:set>
			<!-- 예약내역이 있을 떄 -->
			<c:if test="${fn:length(mybook) ne 0}">
				<table>
					<tr><th>예매번호</th><th>출발날짜</th><th>출발지</th><th>도착지</th><th>편명</th><th>좌석</th><th>상세보기</th></tr>
	
					<c:forEach var="my" items="${mybook }">
					
						<tr>
							<td>
								${my.t_no }
							</td>
							<td>
								${fn:substring(my.t_no ,1,5)}-${fn:substring(my.t_no ,5,7)}-${fn:substring(my.t_no ,7,9)}
							</td>
							<td>
								<c:choose>
								<c:when test="${fn:substring(my.t_no ,0,1) eq 'D'}">인천(ICN)</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${fn:substring(my.air_name,2,3) eq '1'}">제주(CJU)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '2'}">도쿄(NPT)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '3'}">오사카(KIX)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '4'}">후쿠오카(FUK)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '5'}">홍콩(HKG)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '6'}">방콕(BKK)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '7'}">코타키나발루(BKI)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '8'}">블라디보스토크(WO)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '9'}">뉴욕(JFK)</c:when>			
									</c:choose>
								</c:otherwise>
								</c:choose>
							</td>
					
							<td>
								<c:choose>
								<c:when test="${fn:substring(my.t_no ,0,1) eq 'R'}">인천(ICN)</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${fn:substring(my.air_name,2,3) eq '1'}">제주(CJU)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '2'}">도쿄(NPT)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '3'}">오사카(KIX)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '4'}">후쿠오카(FUK)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '5'}">홍콩(HKG)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '6'}">방콕(BKK)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '7'}">코타키나발루(BKI)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '8'}">블라디보스토크(WO)</c:when>
										<c:when test="${fn:substring(my.air_name,2,3) eq '9'}">뉴욕(JFK)</c:when>			
									</c:choose>
								</c:otherwise>
								</c:choose>
							</td>
							<td>
								${my.air_name }
							</td>
							<td>
								<c:if test="${my.s_no eq null}">
								<input type="button" id="btnGoCheckIn" value="체크인" onclick="javascript:goCheckIn('${my.t_no}','${my.air_name}')">
								</c:if>
								<c:if test="${my.s_no ne null}">
								${my.s_no }
								</c:if>
							</td>
							<td>
								<input type="button" value="상세보기" onclick="javascript:funcdetail('${my.t_no}')">
							</td>
							</tr>
						
					</c:forEach>	
				</table>
			</c:if>
			
			<!-- 예약내역이 없을 떄 -->
			<c:if test="${fn:length(mybook) eq 0}">
				예약내역이 없습니다.
			</c:if>
		</div>	
		
		<form action="seat" method="post" name="frm">
			<input type="hidden" id="t_no" name="t_no" value="">
			<input type="hidden" id="inwon" name="inwon" value="">
			<input type="hidden" id="a_seat" name="a_seat" value="">
			<input type="hidden" id="g_id" name="g_id" value="<%=g_id %>">
		</form>
		
		   <form action="detail" method="post" id="detail">
			   <input type="hidden" name="t_no">
			   <input type="hidden" name="o_sdate">
   		</form>
	</div>
	
</body>
</html>