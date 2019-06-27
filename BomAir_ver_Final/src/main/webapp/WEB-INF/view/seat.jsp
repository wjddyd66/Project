<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
    <%
    String g_id=(String) session.getAttribute("id"); 
    /*
    int inwon=2;
    String a_seat="testing105a";
    */
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bom Air : Seat Choice</title>
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.4.0.js"
  integrity="sha256-DYZMCC8HTC+QDr5QNaIcfR7VSPtcISykd+6eSmBW5qo=" crossorigin="anonymous"></script>
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">-->
<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> -->
<!-- 직접 정의한 CSS -->
<link rel="stylesheet" href="resources/css/seat.css"> 
<script>
var confirmValue=false;
var inwon=${inwon};
//console.log(inwon);

$(document).ready(function(){
	
	<c:forEach var="s" items="${data}">	
		<c:set var="seatNo" value="${fn:substring(s.s_no, 0, 1)}"></c:set>
		// console.log(${s.s_no});
	    $("#${s.s_no}_lb").attr("disabled",true)
	    $("#${seatNo}_div").attr("style", "background-color: red")
	</c:forEach>
	
	// 체크박스 클릭 시 
	$("input[type=checkbox]").change(function(){
		
		var seatNo=$(this).attr('id');
		
		if($(this).is(":checked")){
			if(inwon>0){ // 정상적인 상태
				$("#gogekSeat").val(seatNo);
	    		$("#modal_seatCheck").modal('toggle');
			} else { // 예약인원수 이상 클릭 시도할 때
				jQuery("label[for="+$(this).attr('id')+"]").addClass("active");
				alert("예약한 인원수만큼 좌석선택이 완료되었습니다." );
			} 
			
        } else{ // 이미 선택된 좌석을 한번 더 클릭 시
        	if(confirm("정말 해당 좌석 선택을 취소하시겠습니까?")){
        		var class_seatNo="."+seatNo;
        		console.log(class_seatNo);
        		jQuery(class_seatNo).remove();
        		jQuery("label[for="+$(this).attr('id')+"]").addClass("active");
        		inwon++;
        		alert(seatNo+"번 좌석을 취소하였습니다.");
        	} else {
        		jQuery("label[for="+$(this).attr('id')+"]").removeClass("active");
        	}
        }
		
		// 모달 상태에서 체크인버튼 클릭 시
		$("#btnCheckIn").click(function(){
			if($("#gogekName").val()===""){
				jQuery("label[for=gogekName]").empty();
				jQuery("label[for=gogekName]").append("탑승자 성명을 기입해주세요.");
				jQuery("label[for=gogekName]").fadeIn('fast');
				$("#gogekName").focus();
				setTimeout(function() {
					jQuery("label[for=gogekName]").fadeOut();
				}, 500);
				
			} else if($("#gogekBookNo").val()===""){
				jQuery("label[for=gogekBookNo]").empty();
				jQuery("label[for=gogekBookNo]").append("탑승자 예약번호를 기입해주세요.");
				jQuery("label[for=gogekBookNo]").fadeIn('fast');
				$("#gogekBookNo").focus();
				setTimeout(function() {
					jQuery("label[for=gogekBookNo]").fadeOut();
				}, 500);
				
			} else if($("#gogekPassport").val()===""){
				jQuery("label[for=gogekPassport]").empty();
				jQuery("label[for=gogekPassport]").append("탑승자 여권번호를 기입해주세요.");
				jQuery("label[for=gogekPassport]").fadeIn('fast');
				$("#gogekPassport").focus();
				setTimeout(function() {
					jQuery("label[for=gogekPassport]").fadeOut();
				}, 500);
				
			} else {
				var tagForSeatCheck="";
				tagForSeatCheck+="<label class='"+$("#gogekSeat").val()+"'>";
				tagForSeatCheck+="<input type='hidden' name= 's_no' value='"+$("#gogekSeat").val()+"'>";
				tagForSeatCheck+="<input type='hidden' name= 't_no' value='"+$("#gogekBookNo").val()+"'>";
				tagForSeatCheck+="<input type='hidden' name= 'b_name' value='"+$("#gogekName").val()+"'>";
				tagForSeatCheck+="<input type='hidden' name= 'b_pp' value='"+$("#gogekPassport").val()+"'>";
				tagForSeatCheck+="<input type='hidden' name= 'g_id' value='"+"<%=g_id%>"+"'>";
				tagForSeatCheck+="</label>";
				jQuery(".hiddenArea").append(tagForSeatCheck);
				
				var tagForConfirm="";
				tagForConfirm+="<label class='"+$("#gogekSeat").val()+"'>";
				tagForConfirm+="좌석번호: "+$("#gogekSeat").val()+"&nbsp;&nbsp;";
				tagForConfirm+="탑승자명: "+$("#gogekName").val()+"&nbsp;&nbsp;";
				tagForConfirm+="여권번호: "+$("#gogekPassport").val();
				tagForConfirm+="</label><br><br>";
				jQuery("#modal_confirmBody").append(tagForConfirm);
				
				console.log($("#gogekSeat").val()+", "+$("#gogekBookNo").val()+", "+$("#gogekName").val()+", "+$("#gogekPassport").val()+", "+"<%=g_id%>");
				
				inwon--;
				alert($("#gogekSeat").val()+"번 좌석 선택이 완료되었습니다.");
				$("#modal_seatCheck").modal('toggle');
				
				$("#gogekName").val("");
				$("#gogekPassport").val("");
			}
		})
		
		$("#choiceCancel").click(function(){
			console.log($("#gogekSeat").val()+"취소");
			$("#gogekName").val("");
			$("#gogekPassport").val("");
			jQuery("label[for="+$("#gogekSeat").val()+"]").removeClass("active");
		});
		
		$("#btnGoNext").click(function(){
			$("#modal_confirm").modal('toggle');
			$("form[name=frm]").submit();
		});
		
		$("#btnBack").click(function(){
			// alert("go back");
			$("#modal_confirm").modal('toggle');
		});
		
    });
});

function confirmCheck(){
	if(inwon===0){
		console.log(inwon);
		$("#modal_confirm").modal('toggle');
	}else{
		alert("예약한 인원만큼 좌석을 체크인 해주세요.");				
	}
}
</script> 
</head>
<body> 

<div class="container basicFont">
	<div class="SeatTop">
		<a href="index.jsp"><img src="resources/images/bomair_logo.png"/></a>
		<p class="font_title">좌석 지정 페이지</p>
		<hr class="hrCss">
	</div>
	
	<!-- 좌석 현황 표출 -->
	<div class="showSeatArea">
			<div class="btn-group" data-toggle="buttons" id="F_div">
				<label class="btn btn-big btn-primary" for="F1" id="F1_lb"><input
					type="checkbox" autocomplete="off" id="F1" value="F1">F1</label> <label
					class="btn btn-big btn-primary" for="F2" id="F2_lb"><input
					type="checkbox" autocomplete="off" id="F2">F2</label> <label
					class="btn btn-big btn-primary" for="F3" id="F3_lb"><input
					type="checkbox" autocomplete="off" id="F3">F3</label>
			</div>
			<br>
			<br>
			<div class="btn-group" data-toggle="buttons" id="E_div">
				<label class="btn btn-big btn-primary" for="E1" id="E1_lb"><input
					type="checkbox" autocomplete="off" id="E1">E1</label> <label
					class="btn btn-big btn-primary" for="E2" id="E2_lb"><input
					type="checkbox" autocomplete="off" id="E2">E2</label> <label
					class="btn btn-big btn-primary" for="E3" id="E3_lb"><input
					type="checkbox" autocomplete="off" id="E3">E3</label>
			</div>
			<br>
			<br>
			<div class="btn-group" data-toggle="buttons" id="B_div">
				<label class="btn btn-big btn-primary" for="B1" id="B1_lb"><input
					type="checkbox" autocomplete="off" id="B1">B1</label> <label
					class="btn btn-big btn-primary" for="B2" id="B2_lb"><input
					type="checkbox" autocomplete="off" id="B2">B2</label> <label
					class="btn btn-big btn-primary" for="B3" id="B3_lb"><input
					type="checkbox" autocomplete="off" id="B3">B3</label>
			</div>
			<br>
			<br>
		</div>
	
	<!-- Modal : 좌석 체크  -->
	<div class="modal fade" id="modal_seatCheck" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">체크인 : 좌석선택</h4>
	      </div>
	      <div class="modal-body">
	      		<div class="form-group">
		            좌석번호 : <label for="gogekSeat" class="control-label"></label>
		            <input type="text" class="form-control" id="gogekSeat" value="" readonly/>
		          </div>
		           <div class="form-group">
		            탑승자 예약번호 : <label for="gogekBookNo" class="control-label dispAlert" style="color:red;"></label>
		            <input type="text" class="form-control" id="gogekBookNo" value="${t_no }" readonly/>
		          </div>
		          <div class="form-group">
		            탑승자 성명 : <label for="gogekName" class="control-label dispAlert" style="color:red;"></label>
		            <input type="text" class="form-control" id="gogekName">
		          </div>
		          <div class="form-group">
		            탑승자 여권번호 : <label for="gogekPassport" class="control-label dispAlert" style="color:red;"></label>
		            <input type="text" class="form-control" id="gogekPassport">
		          </div>
	      </div>
	      <div class="modal-footer">
	        <button class="btn btn-default" data-dismiss="modal" id="choiceCancel">취소</button>
	        <button class="btn btn-primary" id="btnCheckIn">체크인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Modal : 체크인 내역 최종확인 -->
	<div class="modal fade" id="modal_confirm" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">좌석 선택 내역 확인</h4>
	        <h5 class="modal-title" id="myModalLabel">한 번 체크인한 좌석은 변경할 수 없으니 신중히 확인해주세요.</h5>
	      </div>
	      <div id="modal_confirmBody" class="modal-body">
	      
	      </div>
	      <div class="modal-footer">
	        <button class="btn btn-default" data-dismiss="modal" id="btnBack">돌아가기</button>
	        <button class="btn btn-primary" id="btnGoNext">최종 완료하기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 최종전송 폼 -->
	<form action="showCheckinInfo" method="POST" name="frm">
		<input type="hidden" name="seatTableName" value="${a_seat }">
		<div class="hiddenArea"></div>
		<div class="css_btnSubmit">
			<input type="button" value="체크인 완료하기" class="btn btn-big btn-success" onclick="confirmCheck();">
		</div>
	</form>

	<br><br>	
	<!-- <a href="showCheckinInfo">Go to 체크인 내역 확인 페이지 (확인용, 철거예정)</a> -->
	
</div>	
</body>
</html>