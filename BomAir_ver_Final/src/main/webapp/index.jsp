<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<!-- Bootstrap -->
<%@include file="/bootstrap.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/style.css">
<title>BOM AIR :: Best Of Most Airline & Rent Car</title>
</head>
<body>

	<!-- 상단 네비게이션 메뉴바 -->
	<header>
		<%@include file="./header.jsp"%>
	</header>
	
	<!-- 배경화면 슬라이드 -->

	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="resources/images/bg1.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="resources/images/bg2.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="resources/images/bg3.jpg" class="d-block w-100" alt="...">
			</div>
		</div>
		<div class="modal" id="myModal" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-body">
						성인: <input type="button" id="decAd" value="▽"><span
							id="numberUpDown1">1</span><input type="button" id="incAd"
							value="△"><br> <br>소아: <input type="button"
							id="decCh" value="▽"><span id="numberUpDown2">0</span><input
							id="incCh" type="button" value="△"><br> <br>유아:
						<input type="button" id="decBa" value="▽"><span
							id="numberUpDown3">0</span><input id="incBa" type="button"
							value="△"><br>
						<hr>
						<b>소아</b> : 국내선 만 2세~만12세<Br> 국제선 만 2세~만11세<br> <b>유아</b>
						: 만2세 미만<br>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn" id="inwonOk">확인</button>
						<button type="button" class="btn" data-dismiss="modal"
							id="inwonClose">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="gonggi2">
		<div class="row" style="width: 1000px">
			<div class="col-md-6">
				<h2>
					<a href="gong_list?spage=1">공지사항</a>
				</h2>
				<ul class="timeline" id="gonggi_content">

				</ul>
			</div>
		</div>
	</div>
	
	<div id="accorDiv">
		<div class="accordian">
			<ul>
				<li>
					<div class="image_title"></div> <a href="#"> <img
						src="resources/images/bg1.jpg">
				</a>
				</li>
				<li>
					<div class="image_title"></div> <a href="#"> <img
						src="resources/images/bg2.jpg">
				</a>
				</li>
				<li>
					<div class="image_title"></div> <a href="#"> <img
						src="resources/images/bg3.jpg">
				</a>
				</li>
				<li>
					<div class="image_title"></div> <a href="#"> <img
						src="resources/images/bg1.jpg">
				</a>
				</li>
				<li>
					<div class="image_title"></div> <a href="#"> <img
						src="resources/images/bg2.jpg">
				</a>
				</li>
			</ul>
		</div>
	</div>
	<!-- 빠른예약 창 -->
	<div class="imsi-container">
		<div class="row text-center">
			<div class="col-xl-12">
				<div class="pricing-table">
					<div class="panel panel-primary" style="border: none;">
						<div class="controle-header panel-heading panel-heading-landing">
							<h1 class="panel-title panel-title-landing">
								<img class="brand-logo-light" src="resources/images/bomair_logo.png" 
									style="width:50%;">
							</h1>
						</div>
						<div
							class="controle-panel-heading panel-heading panel-heading-landing-box">
							Best Of Most Airline & Rent Car</div>
						<div class="panel-body panel-body-landing">
							<!-- 빠른예약 창(항공권)-->
							<table class="table" id="reservation-table" style="width: 380px;">
								<tr>
									<td style="width: 50%"><input type="button" value="항공권"
										name="reservation" style="width: 100%"></td>
									<td style="width: 50%"><input type="button" value="렌트카"
										name="rent" style="width: 100%"></td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: center;" class="flightWay">
									<input type="radio" name="flightWay" value="round" checked="checked"/>왕복
									<input type="radio" name="flightWay" value="one_way" />편도
									<td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: center;"><select
										id="Depart" style="width: 100%">
											<option>출발지 선택</option>
											<option value="inc" style="width: 100%">인천(INC)</option>
									</select></td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: center;"><select
										id="Arrive" style="width: 100%">
											<option>도착지 선택</option>
											<optgroup label="국내">
												<option value="CJU" style="width: 100%">제주(CJU)</option>
											</optgroup>
											<optgroup label="일본">
												<option value="NPT" style="width: 100%">도쿄(NPT)</option>
												<option value="KIX" style="width: 100%">오사카(KIX)</option>
												<option value="FUK" style="width: 100%">후쿠오카(FUK)</option>
											</optgroup>
											<optgroup label="동남아">
												<option value="HKG" style="width: 100%">홍콩(HKG)</option>
												<option value="BKK" style="width: 100%">방콕(BKK)</option>
												<option value="BKI" style="width: 100%">코타키나발루(BKI)</option>
											</optgroup>
											<optgroup label="그외 지역">
												<option value="WO" style="width: 100%">블라디보스토크(WO)</option>
												<option value="JFK" style="width: 100%">뉴욕(JFK)</option>
											</optgroup>
									</select></td>
								</tr>
								<tr id="ReservationDateTr">
									<td id="goDate" style="width: 50%"><input type="text"
										class="testDatepicker" id="GoDateChoose" style="width: 100%"
										placeholder="출발 날짜 선택"></td>
									<td id="backDate" style="width: 50%"><input type="text"
										class="testDatepicker" id="BackDateChoose" style="width: 100%"
										placeholder="복귀 날짜 선택"></td>
								</tr>
								<tr>
									<td colspan="2"><input type="text" id="people"
										name="people" placeholder="인원수" style="width: 100%"
										data-toggle="modal" data-target="#myModal" readonly="readonly"></td>
								</tr>
							</table>




							<table class="table" id="rent-table"
								style="width: 380px; display: none;">
								<tr>
									<td style="width: 50%"><input type="button" value="항공권"
										name="reservation" style="width: 100%"></td>
									<td style="width: 50%"><input type="button" value="렌트카"
										name="rent" style="width: 100%"></td>
								</tr>
								<tr id="RentPlaceTr">
									<td colspan="2" style="text-align: center;"><select
										id="RentPlaceTd" style="width: 100%">
											<option id="RentPlace_Sel_Opt">렌트 장소 선택</option>
											<optgroup label="국내">
												<option value="CJU" style="width: 100%">CJU(제주)</option>
											</optgroup>
											<optgroup label="일본">
												<option value="NPT" style="width: 100%">NPT(도쿄)</option>
												<option value="KIX" style="width: 100%">KIX(오사카)</option>
												<option value="FUK" style="width: 100%">FUK(후쿠오카)</option>
											</optgroup>
											<optgroup label="동남아">
												<option value="HKG" style="width: 100%">HKG(홍콩)</option>
												<option value="BKK" style="width: 100%">BKK(방콕)</option>
												<option value="BKI" style="width: 100%">BKI(코타키나발루)</option>
											</optgroup>
											<optgroup label="그외 지역">
												<option value="WO" style="width: 100%">WO(블라디보스토크)</option>
												<option value="JFK" style="width: 100%">JFK(뉴욕)</option>
											</optgroup>
									</select></td>
								</tr>
								<tr id="RentDateTr">
									<td id="goDate" style="width: 50%"><input type="text"
										class="testDatepicker" id="RentDateChoose" style="width: 100%"
										placeholder="렌트 날짜 선택"></td>
									<td id="backDate" style="width: 50%"><input type="text"
										class="testDatepicker" id="ReturnDateChoose"
										style="width: 100%" placeholder="반납 날짜 선택"></td>
								</tr>
							</table>
						</div>
						<div class="panel-footer panel-footer-landing" id="searchHang">
							<a href="#" class="btn btn-price btn-success btn-lg"
								id="reservationsubmit" >일정으로 조회</a>
						</div>

						<div class="panel-footer panel-footer-landing" id="searchRent"
							style="display: none;">
							<a href="#" class="btn btn-price btn-success btn-lg" id="rentsubmit">일정으로 조회</a>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>


	<ul class="sci" style="opacity: 0.5">
		<li><a href="https://blog.naver.com/mint3081"><img
				src="resources/images/facebook.png"></a></li>
		<li><a href="#"><img src="resources/images/twitter.png"></a></li>
		<li><a href="#"><img src="resources/images/instagram.png"></a></li>
	</ul>


	<a id="back-to-top" href="#" class="btn btn-primary btn-lg back-to-top"
		role="button" data-toggle="tooltip" data-placement="left"><span
		class="glyphicon glyphicon-chevron-up"></span></a>
	<%@include file="./bottom.jsp"%>

			<form action="airinfo" method="post" id="O_frm">
						<input type="hidden" name="l_code">
						<input type="hidden" name="o_sdate">
						<input type="hidden" name="people">	
			</form>
			
			<form action="airinfo_R" method="post" id="R_frm">
						<input type="hidden" name="l_code">
						<input type="hidden" name="o_sdate">
						<input type="hidden" name="o_sdate_R">
						<input type="hidden" name="people">	
			</form>
			
	<form action="rent" id="frm" method="post">
		<input type="hidden" name="aa" id="aa">
		<input type="hidden" name="bb" id="bb">
		<input type="hidden" name="cc" id="cc">
	</form>
	
</body>
</html>
