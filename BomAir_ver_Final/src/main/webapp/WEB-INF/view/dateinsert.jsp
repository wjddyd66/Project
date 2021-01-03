<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

** 편도 **
<br>
		<form action="airinfo" method="post">
		
		도시선택 : <input type="text" name="l_code"><br>
		출발날짜 : <input type="text" name="o_sdate"><br>
		성인 인원 : <input type="text" name="people"><br>
		<input type="submit" value="예약하기">
		</form>
		
		<br>
		<hr>
		<br>
** 왕복 **
<br>
		<form action="airinfo_R" method="post">
		
		도시선택 : <input type="text" name="l_code"><br>
		출발날짜 : <input type="text" name="o_sdate"><br>
		귀국날짜 : <input type="text" name="o_sdate_R"><br>		
		성인 인원 : <input type="text" name="people"><br>
		<input type="submit" value="예약하기">
		</form>
</body>
</html>