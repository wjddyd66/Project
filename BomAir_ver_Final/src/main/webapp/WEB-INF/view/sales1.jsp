<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String ab = request.getParameter("ad_date"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.0.min.js" ></script>
<link rel="stylesheet" href="resources/css/mybook.css">
<link rel="stylesheet" href="resources/css/login.css">
<script type="text/javascript">
function functot() {
	
	location.href="saletot";
}
</script>

</head>
<body class="basicFont container">
<div class="logo"><a href="index.jsp"><img src="resources/images/bomair_logo.png"/></a></div>
<h1> * <%=ab.substring(1,11) %> 매출 * </h1>
<br>
<input type="button" value="전체매출" onclick="javascript:functot()" class="btn btn-lg btn-primary2 btn-block" style="width: 100px; height: 50px">
<input type="button" value="이전으로 " onclick="history.back(-1)" class="btn btn-lg btn-primary2 btn-block" style="width: 100px; height: 50px">

<hr class="hrCss">
<br>
<table border="1">
	<tr>
		<th>예약날짜</th><th>예약번호</th><th>예약자</th><th>출발날짜</th><th>좌석클래스</th><th>인원</th><th>결제금액</th>
	</tr>

		
		<c:forEach var="s" items="${sales }">
	<tr>
		<td>${s.ab_date }</td>
		<c:set var="ab_date" value="${s.ab_date }"></c:set>
		<td>${s.t_no }</td>
		<td>${s.g_id }</td>
		<td>${fn:substring(s.t_no,1,5) }-${fn:substring(s.t_no,5,7) }-${fn:substring(s.t_no,7,9) }</td>		
		<td>
		<c:choose>
		<c:when test="${fn:substring(s.t_no,10,11) eq 'E'}">Economy(일반석)</c:when>
		<c:when test="${fn:substring(s.t_no,10,11) eq 'B'}">Business(이등석)</c:when>
		<c:when test="${fn:substring(s.t_no,10,11) eq 'F'}">First(일등석)</c:when>
		</c:choose>
		</td>			
		
		<td>${fn:substring(s.t_no,11,12)}명</td>
		<c:choose>

		<c:when test="${fn:substring(s.t_no,0,1) eq 'D'}">
		<td><fmt:formatNumber value="${s.pay }" pattern="#,###" /> KRW</td>
		<c:set var="totpay" value="${totpay + s.pay }"></c:set>
		</c:when>		
		<c:when test="${fn:substring(s.t_no,0,1) eq 'R'}">
		<td>-</td>
		</c:when>
		</c:choose>
		
	
		
	</tr>
		</c:forEach>
</table>
	<br>

	<div style="margin-left: 200px">
	 <h2 style="color: red;">총 <%=ab.substring(1,11) %> 매출금액 : <fmt:formatNumber value="${totpay }" pattern="#,###" /> KRW</h2>
	</div>
</body>
</html>