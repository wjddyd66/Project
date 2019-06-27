<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String id = (String) session.getAttribute("id");
%>
<script src="resources/js/login.js"></script>
<div class="container">
	<nav class="navbar navbar-expand-lg navbar-light fixed-top">
		<a class="navbar-brand" href="goindex"><img
						class="brand-logo-light"
						src="resources/images/bomair_logo.png" style="width:20%; padding-top: 5px;"></a>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ml-lg-auto">
				
				
				<c:if test="${id ne null }">
					<li class="nav-item dropdown" style="color:white;">${id }님<br>안녕하세요!</li>				
				</c:if>
				
				<c:if test="${id eq 'admin' }">
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="dropdown01"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Admin Page</a>
					<div class="dropdown-menu" aria-labelledby="dropdown01">
						<a class="dropdown-item" href="insert">데이터베이스</a> 
						<a class="dropdown-item" href="cal">매출현황 </a>
					</div></li>
				</c:if>

				<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="dropdown01"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">항공권
						예매</a>
					<div class="dropdown-menu" aria-labelledby="dropdown01">
						<a class="dropdown-item" href="booking">항공권 예매</a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="mybook?g_id=${id }">나의
						예매</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="dropdown03"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">서비스
						안내</a>
					<div class="dropdown-menu" aria-labelledby="dropdown03">
						<a class="dropdown-item" href="#">운임 안내</a> <a
							class="dropdown-item" href="#">기내 서비스</a>
					</div></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="dropdown04"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">렌터카/여행자
						보험</a>
					<div class="dropdown-menu" aria-labelledby="dropdown04">
						<a class="dropdown-item" href="gomycarpage?id=${id}">렌트카</a> 
						<c:if test="${id eq 'admin' }">
									<a class="dropdown-item" href="admincar">렌트카 모든 예약 확인</a> 
								</c:if>
						<a class="dropdown-item"
							href="#">여행자 보험 </a>
					</div></li>

				<c:if test="${id ne null }">
					<li class="nav-item"><a class="nav-link" href="#"
						onclick='confirmLogout()'>로그아웃</a></li>
					<li class="nav-item"><a class="nav-link" href="mypage?g_id=${id}">마이페이지</a></li>
				</c:if>
				<c:if test="${id eq null }">
					<li class="nav-item"><a class="nav-link" href="login">로그인</a></li>
					<li class="nav-item"><a class="nav-link" href="register">회원가입</a></li>
				</c:if>

			</ul>
		</div>
	</nav>
</div>