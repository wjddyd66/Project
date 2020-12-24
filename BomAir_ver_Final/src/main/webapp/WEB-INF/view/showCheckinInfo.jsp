<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Bom Air : Show Checkin Info</title>
<!-- 직접 정의한 CSS -->
<link rel="stylesheet" href="resources/css/showCheckinInfo.css"> 
</head>
<body>

	<div class="container">
		<h1>체크인 내역 확인 페이지</h1>
		<hr class="hrCss">
		<br>
		
		<div class="dispArea basicFont">
			<!-- 
			<br><br><br>
			결과: <c:out value="${cList}"/>${cList}
			<br>
			<p>체크인 확정 내역(출발날짜, 항공편명, 좌석, 탑승자명 등) 표출</p>
			<br><br><br>
			<a href="index.jsp" class="font_NotoSerif">> Go to BomAir Main</a>	
			<!-- <a href="createTable" class="font_NotoSerif">> Go to CreateTable</a>	 -->
			
			<table>
				<tr>
					<th>출발날짜</th><th>항공편명</th><th>좌석번호</th><th>탑승자명</th><th>여권번호</th>
				</tr>
				<c:forEach var="c" items="${cList}">
					<tr>
						<td>${c.departDate }</td>
						<td>${c.TABLE_NAME }</td>
						<td>${c.s_no }</td>
						<td>${c.b_name }</td>
						<td>${c.b_pp }</td>
					</tr>				
				</c:forEach>
			</table>
		</div>
		<div><a href="index.jsp">BomAir 메인으로 이동</a></div>
		
	</div>

</body>
</html>