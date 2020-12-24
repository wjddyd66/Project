<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/bootstrap.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/rent.css">

<script type="text/javascript">
	function bannap(no, daeil, banil, id) {
		$("#carno").val(no);
		$("#dail").val(daeil);
		$("#banil").val(banil);
		$("#id").val(id);
		$("#deleteRent").submit();

	}
	function insertCarSubmi() {
		$("#imageinsert").submit();

	};
	
	$(document).ready(function() {
	    $('#popupBtn').on("click", function() { 
	 		 window.open("ListPopup","_blank","toolbar=yes,menubar=yes,width=1425,height=927").focus();
	    });
	});
	
	
</script>
<title>Insert title here</title>
</head>
<body>

	<section>
		<header>
			<%@include file="/header.jsp"%>
		</header>


		<div class="container">
			<div class="row col-md-6 col-md-offset-2 custyle">
				<table id="rent_table" class="table table-striped custab">
					<c:if test="${id eq 'admin' }">
						<thead>
							<a href="#" class="btn btn-primary btn-xs pull-right"
								data-toggle="modal" data-target="#myModal"><b>+</b> 차량등록</a>
						</thead>
						<span style="width: 50px;" />
						<thead>
							<a href="#" class="btn btn-primary btn-xs pull-right" id="popupBtn"><b>*</b> 전체 차량보기</a>
						</thead>
					</c:if>

					<c:if test="${data.size() gt 0}">
						<tr>
							<th>이미지</th>
							<th>차량 이름</th>
							<th>차량 종류</th>
							<th>차량 번호</th>
							<th>차량 색깔</th>
							<th>가격</th>
							<th>대여일</th>
							<th>반납일</th>
							<th>장 소</th>
							<c:if test="${id eq 'admin' }">
								<th>아이디</th>
								<th></th>
							</c:if>
						</tr>
						<c:forEach var="s" items="${data}">
							<tr>
								<td><img src="resources/images/${s.c_image }"></td>
								<td>${s.c_name }</td>
								<td>${s.c_jong }</td>
								<td>${s.c_bun }</td>
								<td>${s.c_color }</td>
								<td>${s.c_price }</td>
								<td>${s.c_daeil }</td>
								<td>${s.c_banil }</td>
								<td>${s.c_place }</td>
								<c:if test="${id eq 'admin' }">
									<td>${s.g_id}</td>
									<td><a href="#"
										onclick="bannap('${s.r_no}','${s.c_daeil }','${s.c_banil}','${s.g_id }')">반납완료</a></td>
								</c:if>
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
		</div>
	</section>
	<div class="modal" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-sm" style="margin-left: 0">
			<div class="modal-content" style="width: 600; height: 300;">
				<div class="modal-body" style="font-size: larger;">
					<form:form enctype="multipart/form-data"
						modelAttribute="uploadFile" id="imageinsert" action="imageinsert"
						method="POST">
						<b>차량 이름</b>: <input type="text" name="c_name" id="c_name"
							placeholder="차량이름">
						<br>
						<b>차량 종류</b>: <input type="text" name="c_jong" id="c_jong"
							placeholder="차량종류">
						<br>
						<b>차량 번호</b>: <input type="text" name="c_bun" id="c_bun"
							placeholder="차량번호">
						<br>
						<b>차량 색깔</b>: <input type="text" name="c_color" id="c_color"
							placeholder="차량색깔">
						<br>
						<b>이용 가격</b>: <input type="text" name="c_price" id="c_price"
							placeholder="이용가격">
						<br>
						<b>위치</b>: <input type="text" name="c_place" id="c_place"
							placeholder="위치(영어단축명으로 입력하시오)" style="margin-left: 38px">
						<br>
						<b>이미지</b>: <input type="file" name="file" id="c_image"
							placeholder="이미지">
						<br>
						<form:errors path="file" cssStyle="color:red" />
					</form:form>
					<hr>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn" id="insertCarSubmit"
						onclick="insertCarSubmi()">확인</button>
					<button type="button" class="btn" data-dismiss="modal"
						id="inwonClose">닫기</button>
				</div>
			</div>
		</div>
	</div>


	<form action="deleteRent" id="deleteRent">
		<input type="hidden" id="carno" name="carno"> <input
			type="hidden" id="dail" name="dail"> <input type="hidden"
			id="banil" name="banil"> <input type="hidden" id="id"
			name="id">
	</form>
	<%@include file="/bottom.jsp"%>
</body>

</html>