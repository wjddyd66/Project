<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.0.min.js" ></script>
<link rel="stylesheet" href="resources/css/detail.css">
<script type="text/javascript">
$(document).ready(function(){
	$('#btnMyBook').click(function(){
		
		location.href = "mybook?g_id=${id}";
		
	});
	
	$('#btnhome').click(function(){
		location.href = "airinfo";		
	});
	
});


</script>
</head>
<body>
<h1>${id} 님 예약이 완료되었습니다!!!!!!!!!!!!!</h1>
<br>
가는편!
<table>
	<tr>
		<th>출발지</th><th>도착지</th><th>출발날짜</th><th>출도착시간</th><th>편명</th><th>좌석클래스</th><th>결제금액</th>
	</tr>

	<tr>
		<td>인천 (ICN)</td>
		<td>
		<c:choose>
		<c:when test="${complete.l_code eq 'CJU' }">제주</c:when>
		<c:when test="${complete.l_code eq 'NPT' }">도쿄</c:when>
		<c:when test="${complete.l_code eq 'KIX' }">오사카</c:when>
		<c:when test="${complete.l_code eq 'FUK' }">후쿠오카</c:when>
		<c:when test="${complete.l_code eq 'HKG' }">홍콩</c:when>
		<c:when test="${complete.l_code eq 'BKK' }">방콕</c:when>
		<c:when test="${complete.l_code eq 'BKI' }">코타키나발루</c:when>
		<c:when test="${complete.l_code eq 'WO' }">블라디보스토크</c:when>
		<c:when test="${complete.l_code eq 'JFK' }">뉴욕</c:when>
		<c:otherwise> ... </c:otherwise>
		</c:choose>(${complete.l_code })
		</td>
		<td>${complete.o_sdate }</td>
		<td>${complete.start } ~ ${complete.end }<br>(${complete.time })</td>
		<td>${complete.a_name }</td>
		<td>
		<c:choose>
		<c:when test="${complete.grade eq 'E' }">Economy(일반석)</c:when>
		<c:when test="${complete.grade eq 'B' }">Business(이등석)</c:when>
		<c:when test="${complete.grade eq 'F' }">First(일등석)</c:when>
		</c:choose>
		</td>
		<td>
		<fmt:formatNumber value="${complete.pay }" pattern="#,###" /> KRW
		</td>
	</tr>
</table>
<br>
<hr>
<br>
오는편!
<table border="1">
	<tr>
		<th>출발지</th><th>도착지</th><th>출발날짜</th><th>출도착시간</th><th>편명</th><th>좌석클래스</th><th>결제금액</th>
	</tr>

	<tr>
		<td>
		<c:choose>
		<c:when test="${complete.l_code eq 'CJU' }">제주</c:when>
		<c:when test="${complete.l_code eq 'NPT' }">도쿄</c:when>
		<c:when test="${complete.l_code eq 'KIX' }">오사카</c:when>
		<c:when test="${complete.l_code eq 'FUK' }">후쿠오카</c:when>
		<c:when test="${complete.l_code eq 'HKG' }">홍콩</c:when>
		<c:when test="${complete.l_code eq 'BKK' }">방콕</c:when>
		<c:when test="${complete.l_code eq 'BKI' }">코타키나발루</c:when>
		<c:when test="${complete.l_code eq 'WO' }">블라디보스토크</c:when>
		<c:when test="${complete.l_code eq 'JFK' }">뉴욕</c:when>
		<c:otherwise> ... </c:otherwise>
		</c:choose>(${complete.l_code })
		</td>
		<td>인천 (ICN)</td>
		<td>${complete.o_sdate_R }</td>
		<td>${complete.start_R } ~ ${complete.end_R }<br>(${complete.time_R })</td>
		<td>${complete.a_name_R }</td>
		<td>
		<c:choose>
		<c:when test="${complete.grade_R eq 'E' }">Economy(일반석)</c:when>
		<c:when test="${complete.grade_R eq 'B' }">Business(이등석)</c:when>
		<c:when test="${complete.grade_R eq 'F' }">First(일등석)</c:when>
		</c:choose>
		</td>
		<td>
		<fmt:formatNumber value="${complete.pay }" pattern="#,###" /> KRW
		</td>
	</tr>
</table>
<br>
<br>
<input type="button" value="나의예약정보" id="btnMyBook">

<input type="button" value="확인" id="btnhome">

</body>
</html>