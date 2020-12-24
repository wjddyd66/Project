<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/mybook.css">
</head>
<body class="basicFont container">
<div class="logo"><a href="index.jsp"><img src="resources/images/bomair_logo.png"/></a></div>
<br>
<Br>

** 노선정보 목록 ** <br>
<a href="insert">노선 추가</a><br>
<table border="1">
	<tr>
		<th>노선코드</th><th>항공편명</th><th>출발날짜</th><th>가격</th><th>소요시간</th><th>출발시각</th>
	</tr>

	<c:forEach var="m" items="${list }">
		<tr>
			<td>${m.l_code }</td>
			<td>${m.air_name }</td>
			<td>${m.o_sdate }</td>
			<td>${m.o_price }</td>
			<td>${m.o_soyo }</td>
			<td>${m.o_stime }</td>			
		</tr>
	</c:forEach>
</table>
</body>
</html>