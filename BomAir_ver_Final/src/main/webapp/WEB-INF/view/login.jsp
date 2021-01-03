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
    
    <%@include file="/bootstrap.jsp"%>
    <%@include file="/bootstrap_login.jsp"%>
    <link rel="stylesheet" href="resources/css/login.css"> 
    <script src="resources/js/login.js"></script>
    
    <title>Bom Air : Login Page</title>
  </head>
  
  <body class="basicFont">

    <div class="container">
	  <div class="logo"><a href="index.jsp"><img src="resources/images/bomair_logo.png"/></a></div>
	  <div class="imgLogin col-md-4"><img id="imgLogin" src="resources/images/imgLogin.PNG"/></div>
      <div class="loginField col-md-4">
		        <h4 style="font-size: 25px;">Bom Air에 오신 것을 환영합니다!</h4>
		        
			    <form class="form-signin" action="login" method="post">
			    
			        <label for="inputId" class="sr-only">User Id</label>
			        <input type="text" id="inputId" name="g_id" class="form-control" placeholder="User Id" required autofocus>
			        
			        <label for="inputPassword" class="sr-only">Password</label>
			        <input type="password" id="inputPassword" name="g_pwd" class="form-control" placeholder="Password" required>
			        
			        <div id="showAlert">
			        	<c:if test="${state eq 'loginFail' }">
				        	<p id="alertMessage">아이디 또는 비밀번호를 확인하세요. 봄에어에 등록되지 않은 아이디이거나, 아이디 또는 비밀번호를 잘못 입력하셨습니다.</p>			        	
			        	</c:if>
			        </div>
			        
			        <div class="checkbox">
			          <label>
			            <!-- <input type="checkbox" value="remember-me"> 비밀번호 기억하기 -->
			          </label>
			        </div>
			        
			        <!-- onsubmit="return loginCheck()" -->
			        <input type="submit" class="btn btn-lg btn-primary2 btn-block" value="로그인"/>
			        
			    </form>      	
			    	
		        <br><br>
		        
<!-- The Modal ID-->
    <div id="id_myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content" style="width: 50%; margin-top: 230px; margin-left: 450px">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">아이디 찾기</span></b></span></p>
                <p style="text-align: center; line-height: 1.5;"><br /></p>
                <p style="text-align: center; line-height: 1.5;"><span style="font-size: 14pt;">이름: <input id="find_name" placeholder="이름" /></span></p>
                <p style="text-align: center; line-height: 1.5;"><span style="font-size: 14pt;">휴대전화: 
                <select id="find_g_tel1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>&nbsp;-&nbsp; 
					<input id="find_g_tel2" maxlength="4" type="text"/>&nbsp;-&nbsp;
					<input id="find_g_tel3" maxlength="4" type="text"/></span></p>
                <p style="text-align: center; line-height: 1.5;"><br /></p>
                <p style="text-align: center; line-height: 1.5;"><button class="btn btn-primary btn-lg" id="id_find">아이디 찾기</button></p>
            <div id="find_id_content">Hello</div>
            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="pop_bt" style="font-size: 13pt;" >
                     닫기
                </span>
            </div>
      </div>
 
    </div>
        <!--End Modal-->

<!-- The Modal PWD-->
    <div id="pwd_myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content" style="width: 50%; margin-top: 230px; margin-left: 450px">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">비밀번호 찾기</span></b></span></p>
                <p style="text-align: center; line-height: 1.5;"><span style="font-size: 14pt;">이름: <input id="find_pwd_name" placeholder="이름" /></span></p>
                <p style="text-align: center; line-height: 1.5;"><span style="font-size: 14pt;">휴대전화: 
                <select id="find_pwd_g_tel1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>&nbsp;-&nbsp; 
					<input id="find_pwd_g_tel2" maxlength="4" type="text"/>&nbsp;-&nbsp;
					<input id="find_pwd_g_tel3" maxlength="4" type="text"/></span></p>
                <p style="text-align: center; line-height: 1.5;"><span style="font-size: 14pt;">ID: <input id="find_pwd_id" placeholder="ID" /></span></p><p><br /></p>
            <p style="text-align: center; line-height: 1.5;"><br /></p>
                <p style="text-align: center; line-height: 1.5;"><button class="btn btn-primary btn-lg" id="pwd_find">비밀번호 찾기</button></p>
            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="pop_bt" style="font-size: 13pt;" >
                     닫기
                </span>
            </div>
      </div>
 
    </div>
    
        <!--End Modal-->
		        <div class="goRegister"><a href="register">&nbsp;회원가입</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
		        <a  href="#" onclick='find_id()'>아이디 찾기</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
		        <a  href="#" onclick='find_pwd()'>비밀번호찾기</a>
		        </div>
      </div>		
    </div> <!-- /container -->
  </body>
</html>