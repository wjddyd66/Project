<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/rent.css">
<%@include file="/bootstrap.jsp"%>

<script type="text/javascript">
function rentSubmit(num){
		$("#rentNum").val(num);
	if(confirm("정말 예약하시겠습니까?")){
		if('${id}' != ''){
			$("#rentForm").submit();
		}else{
			if(confirm("로그인 하시겠습니까?"))
				$("#rentForm").submit();
		}		
		}
}
</script>
<title>Insert title here</title>
</head>
<body>

	<section style="margin-top : 100px">
		<header>
			<%@include file="/header.jsp"%>
		</header>


		<div class="container">
			<div class="row col-md-6 col-md-offset-2 custyle">
				<table id="rent_table" class="table table-striped custab">

					<c:if test="${data.size() gt 0}">
						<tr>
							<th>이미지</th>
							<th>차량 이름</th>
							<th>차량 종류</th>
							<th>차량 번호</th>
							<th>차량 색깔</th>
							<th>가격</th>
							<th></th>
						</tr>
						<c:forEach var="s" items="${data}">
							<tr>
								<td style="height: 50px;"><img
									src="resources/images/${s.c_image }"></td>
								<td>${s.c_name }</td>
								<td>${s.c_jong }</td>
								<td>${s.c_bun }</td>
								<td>${s.c_color }</td>
								<td>${s.c_price }</td>
								<td class="text-center"><a class='btn btn-info btn-xs'
									href="#" onclick="rentSubmit(${s.r_no})"><span
										class="glyphicon glyphicon-edit"></span> Rent</a></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${data.size() eq 0}">
						<tr>
							<td>차량정보가 없습니다!</td>
						</tr>
					</c:if>

				</table>

			</div>
			<form action="rentReservation" id="rentForm">
				<input type="hidden" value="${RentDateChoose}" id="RentDateChoose"
					name="RentDateChoose"> <input type="hidden"
					value="${ReturnDateChoose}" id="ReturnDateChoose"
					name="ReturnDateChoose"> <input type="hidden" id="rentNum"
					name="rentNum"> <input type="hidden" name="rentId"
					id="rentId" value="${id}">
			</form>
		</div>
	</section>
	<%@include file="/bottom.jsp"%>
</body>
</html>