<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Bom Air : My Page</title>
<%@include file="/bootstrap_register.jsp"%>
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.4.0.js"
  integrity="sha256-DYZMCC8HTC+QDr5QNaIcfR7VSPtcISykd+6eSmBW5qo=" crossorigin="anonymous"></script>
<%@include file="/bootstrap.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/style.css">
<div id="layer"
	style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
		id="btnCloseLayer"
		style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
		onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
<script src="resources/js/register.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- 직접 정의한 CSS -->
<link rel="stylesheet" href="resources/css/mypage.css">
</head>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#area_UpBirth, #area_UpAddr, #area_pwd, #area_addr, #area_tel").hide();

	$("#btnUpBirthCancel").click(function(){
		$("#area_btnUpBirth").show();
		$("#area_UpBirth").hide();
	})
	
	$("#btnUpPwd").click(function(){
		$("#pwd").attr('required', 'required');
		$("#rpwd").attr('required', 'required');
		$("#area_pwd").show();
	})
	
	$("#btnUpName").click(function(){
		if($("#btnUpName").val()==="수정"){
			$("#g_name").removeAttr("readonly");
			$("#btnUpName").val("되돌리기");
		} else{
			$("#g_name").val('${gdto.g_name}');
			$("#g_name").attr("readonly","readonly");
			$("#btnUpName").val("수정");
		}
	})
	
	$("#btnUpBirth").click(function(){
		if($("#btnUpBirth").val()==="수정"){
			$("#g_birth").removeAttr("readonly");
			$("#btnUpBirth").val("되돌리기");
		} else{
			$("#g_birth").val('${gdto.g_birth}');
			$("#g_birth").attr("readonly","readonly");
			$("#btnUpBirth").val("수정");
		}
	})
	
	$("#btnUpMail").click(function(){
		if($("#btnUpMail").val()==="수정"){
			$("#g_mail").removeAttr("readonly");
			$("#btnUpMail").val("되돌리기");
		} else{
			$("#g_mail").val('${gdto.g_mail}');
			$("#g_mail").attr("readonly","readonly");
			$("#btnUpMail").val("수정");
		}
	})
	
	$("#btnUpAddr").click(function(){
		$("#area_addr").show();
	})
	
	$("#btnUpTel").click(function(){
		$("#g_tel2").attr('required', 'required');
		$("#g_tel3").attr('required', 'required');
		$("#area_tel").show();
	})
	
	$("#btnGoDropMember").click(function(){
		if(confirm("회원 탈퇴를 감행 하시겠습니까?")){
			if(confirm("정.말.로. 감당하실 수 있겠느냐고 물었습니다.")){
				alert("십 리도 못 가서 발병난다...");
				location.href="dropMember?g_id="+'${gdto.g_id}';							
			}
		} else {
				alert("그럼 그렇지ㅋ");
		}
	})
	
})

function showAlert(){
	alert("회원정보 수정이 정상적으로 완료되었습니다.");
}
</script>
<body>

	<!-- 상단 네비게이션 메뉴바 -->
	<header>
		<%@include file="/header.jsp"%>
	</header>

	<div class="container">
		<br>
		<div class="container">
			<h1 class="pull-left">나의 정보</h1>
			<input type="button" id="btnGoDropMember" class="btn btn-danger nextBtn btn-lg pull-right" value="회원탈퇴">		
		</div>
		<hr class="hrCss">
		<br><br>
	</div>
		
		<div class="basicFont showMyInfo">
			<form action="mypage" method="post" name="frm">
			
			<!--remove autocomplete-->
	         <input style="display: none" aria-hidden="true"> 
	         <input type="password" name='non_auto' value=' ' style="display: none" aria-hidden="true">
	         <!--remove autocomplete end-->
	         <!--real input start-->
	         <input type="text" name='non_auto' value=' ' autocomplete="false" required style="display: none"> 
	         <input type="password" name="password" value=' ' autocomplete="new-password" style="display: none">
	         <!--real input end-->
			
			<div>
			
				<table border="1">
				
					<tr>
						<td>
							<label class="control-label">아이디</label>
						</td>
						<td>
							<input type="text" name="g_id" value="${gdto.g_id }" readonly/>
						</td>
					</tr>
					
					<tr>
						<td>
							<label class="control-label">비밀번호</label>
						</td>
						<td>
							<input name="g_pwd" maxlength="200" type="password" class="form-passwd" value="${gdto.g_pwd }" readonly/>
		            		<input type="button" class="btn2" id="btnUpPwd" value="변경하기">	
		            		
		            		<div id="area_pwd">
								<div class="form-group">
					               <label class="control-label">변경 비밀번호: </label>
					               <input id="pwd" maxlength="200" type="password" onchange="checkpwd()"
					                  class="form-passwd" placeholder="비밀번호"/>
				            	</div>
					            <span class="form-group">
					               <label class="control-label">변경 비밀번호 재입력: </label>
					               <input id="rpwd" maxlength="200" type="password" onchange="checkpwd()" 
					               class="form-passwd" placeholder="비밀번호 재입력" />
						        </span>&nbsp;&nbsp;<span id="same"></span>				
							</div>
						</td>
					</tr>
					
					<tr>
						<td>
							<label class="control-label">이름</label>
						</td>
						<td>
							<input name="g_name" maxlength="200" type="text" required="required"
							id="g_name" class="" value="${gdto.g_name }" readonly="readonly"/>
							<input type="button" class="btn2" id="btnUpName" value="수정">	
						</td>
					</tr>
					
					<tr>
						<td>
							<label class="control-label">생년월일</label><br>
							<input type="button" class="btn2" id="btnUpBirth" value="수정">	
						</td>
						<td>
							<input name="g_birth" maxlength="200" type="date" required="required"
							id="g_birth" class="form-control" value="${gdto.g_birth }" readonly="readonly"/>
						</td>
					</tr>
					
					<tr>
						<td>
							<label class="control-label">거주지</label>
						</td>
						<td>
							<input type="text" id="g_addr" name="g_addr" value="${gdto.g_addr }" readonly="readonly">
							<input type="button" class="btn2" id="btnUpAddr" value="수정">	
							<br> 
							<div id="area_addr">
								<input
									type="text" id="postcode" placeholder="우편번호"> <input class="btn2"
									type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
								<input type="text" id="address" onkeyup="addradd()" placeholder="주소"><br> 
								<input type="text" id="extraAddress" placeholder="참고항목">
								<input type="text" id="detailAddress" onkeyup="addradd()" placeholder="상세주소">			
							</div>
						</td>
					</tr>
					
					<tr>
						<td>
							<label class="control-label">휴대전화</label>
						</td>
						<td>
							<input type="text" id="g_tel" name="g_tel" value="${gdto.g_tel }" readonly="readonly">
							<input type="button" class="btn2" id="btnUpTel" value="수정">	
							<br> 
							<div id="area_tel">
								<select id="g_tel1" class="form-control2">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>&nbsp;-&nbsp;
								<input id="g_tel2" maxlength="15" type="text" pattern="\d{3,4}" class="form-control2"/>&nbsp;-&nbsp;
								<input id="g_tel3" maxlength="15" type="text" pattern="\d{4}" class="form-control2"/>
							</div>
						</td>
					</tr>
					
					<tr>
						<td>
							<label class="control-label">이메일</label><br>
							<input type="button" class="btn2" id="btnUpMail" value="수정">
						</td>
						<td>
							<input name="g_mail" id="g_mail" maxlength="200" type="email" required="required"
							class="form-control" placeholder="이메일" value="${gdto.g_mail }" readonly="readonly"/>
						</td>
					</tr>
					
				</table>
				
				<div>
					
				</div>
				
			</div>
			<br><br>
			<div class="btnArea">
				<input type="submit" class="btn btn-primary nextBtn btn-lg btn2-lg" value="수정완료" onclick="showAlert();">
			</div>
			</form>	
		</div>
</body>
</html>