<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">
    
    <%@include file="/bootstrap_registerOk.jsp"%>
    <%@include file="/bootstrap.jsp"%>
    <link href="https://fonts.googleapis.com/css?family=Italianno" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/login.css"> <!-- CSS reset -->
    <script src="resources/js/login.js"></script>
    <title>Bom Air : Register Ok</title>
  </head>
  
  <body>
  
  	<header>
		<%@include file="/header.jsp"%>
	</header>

    <div class="container">
	  <!-- <div class="logo"><a href="index.jsp"><img src="resources/images/bomair_logo.png"/></a></div> -->
	  
      <div class="celebrateMessage">
      	<!--  <h1 style="padding:50px 0 0 0; font-size:60px; font-family: 'Italianno', cursive;"></h1>-->
      	<h2 class="basicFont" style="padding-top:50px; font-size:54px; font-weight: bold;">떠나요~ 다같이! 모든 걸 훌훌 버리고~</h2>
		<h4 class="basicFont" style="font-size:25px; margin-top:15px;">Best Of Most Airline & Rent Car, 봄에어의 회원이 되신 것을 진심으로 환영합니다!</h4>
		<br>
	  	<div class="imgRegisterOk"><img id="imgLogin" src="resources/images/imgLogin.PNG"/></div>
		<input type="button" class="btn-primary2 btnGoMain btn btn-lg2" value="메인으로 가기"/>
      </div>		
    </div> <!-- /container -->

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>