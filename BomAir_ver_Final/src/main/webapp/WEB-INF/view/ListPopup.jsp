<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript">
	$(document).ready(function(){
		window.opener.location.reload();     
	});
	
	function deletecar(no, name) {
		if (confirm("정말삭제하시겠습니까?")) {
			$('#no').val(no);
			$('#name').val(name);
			$('#frm').submit();
		}				
	} 
</script>
<title>Insert title here</title>
</head>
<body>
	<section>
		<div class="container">
			<div class="row col-md-6 col-md-offset-2 custyle">
				<table id="rent_table" class="table table-striped custab">
					<tr>
						<th>이미지</th>
						<th>차량 이름</th>
						<th>차량 종류</th>
						<th>차량 번호</th>
						<th>차량 색깔</th>
						<th>가격</th>
						<th>장 소</th>
						<th></th>
					</tr>
					<c:forEach var="s" items="${cardata}">
						<tr>
							<td><img src="resources/images/${s.c_image }"></td>
							<td>${s.c_name }</td>
							<td>${s.c_jong }</td>
							<td>${s.c_bun }</td>
							<td>${s.c_color }</td>
							<td>${s.c_price }</td>
							<td>${s.c_place }</td>
							<td><a href="#"
								onclick="deletecar('${s.r_no}','${s.c_image}')">삭제</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<form id="frm" action="deleteCar">
			<input type="hidden" name="no" id="no"> <input type="hidden"
				name="name" id="name">
		</form>
	</section>
</body>
</html>