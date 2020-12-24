<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<script>
	function delchk(num,word){
		if(confirm("정말 삭제 하시겠습니까?")){
			location.href="gong_delete?num="+num+"&spage="+<%=request.getParameter("spage")%>+"&sword="+word;
}
}

</script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%@include file="/bootstrap.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/style.css">
<body>
	<header>
		<%@ include file="../../header.jsp"%>
	</header>
	<section>
		<!-- 게시글 목록 -->
		<table border="1" class="table" style="margin-top: 100px">
			<tr style="background-color: silver; color: black;">
				<th>번호</th>
				<th>제목</th>
				<th>조회수</th>
				<th>날짜</th>
				<c:if test="${id eq 'admin' }">
					<th colspan="2">관리자 권한</th>
				</c:if>
			</tr>
			<c:forEach var="s" items="${list}">
				<tr>
					<td>${s.num }</td>
					<td
						onClick="location.href='gong_detail?num=${s.num}&spage=<%=request.getParameter("spage")%>&sword=${sword}'"
						style="cursor: pointer; width: 500px;">${s.title }</td>
					<td>${s.readcnt }</td>
					<td>${s.bdate }</td>
					<c:if test="${id eq 'admin' }">
						<td><a
							href="gong_update?num=${s.num}&spage=<%=request.getParameter("spage")%>&sword=${sword}">수정</a></td>
						<td><a href="#" onclick="delchk(${s.num },'${sword}')">삭제</a></td>
					</c:if>
				</tr>
			</c:forEach>
		</table>

		<!-- 페이징 처리 -->
		<div class='d-flex'>
			<ul class="pagination mx-auto">
				<li class='page-item'><a
					href='gong_list?spage=1&sword=${sword}' class='page-link'>맨 앞</a></li>
				<c:choose>
					<c:when test="${bsu ==1 }">
						<li class='page-item'><a
							href='gong_list?spage=1&sword=${sword}' class='page-link'>이 전</a></li>
					</c:when>
					<c:otherwise>
						<li class='page-item'><a
							href='gong_list?spage=${bsu*5-5}&sword=${sword}'
							class='page-link'>이 전</a></li>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${bsu*5 >su }">
						<c:set var="end" value="${su}" />
					</c:when>
					<c:otherwise>
						<c:set var="end" value="${bsu*5}" />
					</c:otherwise>
				</c:choose>

				<c:forEach begin="${bsu*5-4}" end="${end}" var="x">
					<c:choose>
						<c:when test="${x ==param.spage }">
							<li class='page-item active'><a
								href='gong_list?spage=${x}&sword=${sword}' class='page-link'>${x}</a></li>
						</c:when>
						<c:otherwise>
							<li class='page-item'><a
								href='gong_list?spage=${x}&sword=${sword}' class='page-link'>${x}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:choose>
					<c:when test="${bsu*5 >=su }">
						<li class='page-item'><a
							href='gong_list?spage=${su}&sword=${sword}' class='page-link'>다
								음</a></li>
					</c:when>
					<c:otherwise>
						<li class='page-item'><a
							href='gong_list?spage=${bsu*5+1}&sword=${sword}'
							class='page-link'>다 음</a></li>
					</c:otherwise>
				</c:choose>
				<li class='page-item'><a
					href='gong_list?spage=${su}&sword=${sword}' class='page-link'>맨
						뒤</a></li>
			</ul>
		</div>

		<!-- 메뉴 -->
		<div style="text-align: center; margin-bottom: 120px;">
			<form action="gong_list?spage=1" name="frm" method="post">
				<input type="text" name="sword"> <input type="submit"
					class="btn btn-outline-dark" value="검색" id="btnSearch">
				<c:if test="${id eq 'admin' }">
					<a class='nav-link' href='gong_write'>새글 추가</a>
				</c:if>
			</form>
		</div>
	</section>
	<%@ include file="/bottom.jsp"%>
</body>
</html>