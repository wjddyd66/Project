<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Write something else you want</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/
3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous">
	
</script>
</head>
<%@include file="/bootstrap.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/style.css">
<body>
<header>
		<%@ include file="../../header.jsp"%>
	</header>
	<section style="margin-top: 100px">
	<div class="container">
		<table class="table table-bordered">
			<thead>
			</thead>
			<tbody>
				<form action="gong_regist" method="get" id="frm">
					<tr>
						<th>제목:</th>
						<td><input type="text" placeholder="제목을 입력하세요. " name="subject" class="form-control" id='subject' value='${dto.title}' readonly="readonly"/></td>
						<th>날짜:</th>
						<td><input type="text" name="date" class="form-control" id="date" value='${dto.bdate}' readonly="readonly"/></td>
					</tr>
					<tr>
						<th>내용:</th>
						<td colspan="4"><textarea cols="10" rows="20" placeholder="내용을 입력하세요. " name="content" class="form-control" id="content" readonly="readonly">${dto.con}</textarea></td>
					</tr>
					<tr>
							<input type="button" value="글 목록으로... " class="pull-right" onclick="javascript:location.href='gong_list?spage=${spage}&sword=${sword}'"/></td>
					</tr>
				</form>
			</tbody>
		</table>
	</div>
	</section>
	<%@ include file="/bottom.jsp"%>
</body>
</html>