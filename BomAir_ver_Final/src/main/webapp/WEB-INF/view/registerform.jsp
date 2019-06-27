<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<%@include file="/bootstrap_register.jsp"%>
<link href="https://fonts.googleapis.com/css?family=Italianno" rel="stylesheet">
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/register.css">
<title>회원가입</title>
<!-- 우편번호 div -->
<div id="layer"
	style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
		id="btnCloseLayer"
		style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
		onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="resources/js/register.js"></script>
</head>
<body>

	<div class="container">
		<form action="register" method="post" onsubmit="return check();">
			
			<!--remove autocomplete-->
			<input style="display: none" aria-hidden="true"> 
			<input type="password" name='non_auto' value=' ' style="display: none" aria-hidden="true">
			<!--remove autocomplete end-->
			<!--real input start-->
			<input type="text" name='non_auto' value=' ' autocomplete="false" required style="display: none"> 
			<input type="password" name="password" value=' ' autocomplete="new-password" style="display: none">
			<!--real input end-->
			
			<div class="row setup-content" id="step-1">
				<h1 align="center" style="padding:10px 0 0 0; font-size:40px; font-family: 'Italianno', cursive;">Best Of Most Airline & Rent Car</h1>
				<h2 align="center" style="font-weight:bolder; font-size:40px;">봄에어 회원가입을 환영합니다.</h2>
				<br><br><br><br><br>
				<div class="stepwizard">
					<div class="stepwizard-row setup-panel">
						<div class="stepwizard-step">
							<a href="#step-1" type="button" class="btn btn-primary btn-circle"
								id="btn1">1</a>
							<p>Step 1</p>
						</div>
						<div class="stepwizard-step">
							<a href="#step-2" type="button" class="btn btn-default btn-circle"
								disabled="disabled" id="btn2">2</a>
							<p>Step 2</p>
						</div>
					</div>
				</div>
				
					<div class="d1">
					<br /> <br />
					<div id="accordion">
						<h3>
							<input type="checkbox" name="c1" id="c1" />&nbsp;<label for="c1">이용약관 동의(필수)</label>
						</h3>
						<td><textarea readonly="readonly" rows="30" cols="120">
▶ 봄에어클럽 개인 정보 수집 및 이용 안내

[개인정보의 수집 목적 및 이용]
봄에어항공은 서비스 제공 및 마케팅 활동을 위해 회원의 동의를 얻어 개인정보를 수집하고 있습니다.

 

[개인정보 수집 항목]
가. 봄에어클럽 회원 가입 시 
   - 필수항목 : 한글 및 영문 성명 , 성별, 전화번호, 주소, 우편번호, 이메일, 국적, 거주국가, 본인 인증번호, 아이디,비밀번호
     - 만 14세 미만 회원 가입 시 추가 수집 항목 : 법정대리인의 성명,생년월일

나. 봄에어클럽 가족회원 등록 : 가족관계를 증빙할 수 있는 서류

 

[개인정보의 보유 및 이용기간]
봄에어항공은 회원이 봄에어클럽을 탈퇴하거나 자격을 상실하는 경우 또는 수집목적을 달성하거나 사업을 폐업하는 경우에는 회원DB 삭제, 문서 파기 등의 방법으로 해당 개인정보를 1일내 파기하고 있습니다. 다만, 전자상거래 등에서의 소비자보호에 관한 법률 등 관련 법령의 규정에 의하여 보존하여야 하는 기록은 일정 기간 보관 후 파기합니다. (계약 또는 청약철회 등에 관한 기록: 5년, 대금결제 및 재화 등의 공급에 관한 기록: 5년, 소비자의 불만 또는 분쟁처리에 관한 기록: 3년)
 

 

▶ 홈페이지 개인정보 수집 및 이용 안내

[개인정보의 수집 목적 및 이용]
가. 서비스 제공을 위한 계약의 이행
항공권 예약발권, 면세품 사전 주문, 콘텐츠 제공,금융거래 본인인증 및 금융서비스 등

나. 회원 관리
회원제 서비스 이용, 개인식별, 가입의사 확인, 민원처리 등

다. 마케팅 및 광고 활용
기타 새로운 서비스, 신상품이나 이벤트 정보 안내, 서비스 이용 통계 등

 

[개인정보 수집 항목]
가. 항공권 예매 시
     - 탑승자 성명, 회원번호(회원인 경우) , 생년월일(소아, 유아인 경우) , 전화번호, 이메일(선택적)
     - 신용카드 결제( 카드번호, 거래 인증번호), 계좌이체(거래은행명, 계좌번호)
     - 여권정보 (여권번호, 만료일, 발급처, 국적)

나. 고객센터 이용 시 
     - 성명, 연락처 , 이메일 주소(선택적), 회원번호(선택적), 생년월일(선택적), 탑승정보(선택적)

다. 면세품 주문 시
     - 주문자 성명(또는 회원 성명), 탑승자 성명, 회원번호 또는 생년월일, 연락 전화번호, 이메일 주소, 카드번호 및 카드 인증 정보, 포인트 상품 배송 주소
※ 비회원의 경우 기내면세품 전달을 위해 봄에어항공은 성명, 생년월일, 탑승편 정보 등 필요한 최소한의 정보만을 수집합니다.

라. 이벤트 응모 시
     - 이벤트 응모 과정에서 회원 가입 시 수집하지 않았던 개인정보를 추가로 수집할 때에는 이용자들에게 고지하고 동의를 받습니다.

마. 자동으로 생성되는 개인정보 
     - 서비스 이용기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록

 

[개인정보의 보유 및 이용기간]
가. 이용자가 제공한 개인정보는 봄에어항공이 제공하는 서비스를 받는 동안 봄에어항공이 보유ㆍ이용하게 됩니다.

나. 봄에어클럽의 개인정보의 보유 기간 및 파기 절차는 봄에어클럽 개인정보취급방침에 따릅니다.

다. 전자상거래등에서의 소비자보호에 관한 법률 등 관계법령의 규정에 의하여 보존하여야 하는 기록은 일정 기간 보관 후 파기합니다.
     - 계약 또는 청약철회 등에 관한 기록 (보존기간 : 5년) : 전자상거래 등에서의 소비자 보호에 관한 법률
     - 대금결제 및 재화 등의 공급에 관한 기록 (보존기간 : 5년) : 전자상거래 등에서의 소비자 보호에 관한 법률
     - 소비자의 불만 또는 분쟁처리에 관한 기록 (보존기간 : 3년) : 전자상거래 등에서의 소비자 보호에 관한 법률
     - 홈페이지 방문에 관한 기록 (보존 기간: 3개월) : 통신비밀보호법
     - 이벤트 참여 기록 (보존 기간 : 1년) : 당사에서 정한 기준
     - 기타 보유 정보: 정보의 수집 및 이용 목적이 달성된 때

라. 전항의 규정에도 불구하고, 상법, 전자상거래 등에서의 소비자 보호에 관한 법률 등 관계법령의 규정에 따라 보존의 필요성이 있는 경우 혹은 요금의 정산, 소송 등 법적 분쟁에 대비하기 위하여 개인정보에 대한 계속적인 보유의 필요성이 있어 보유목적, 기간, 보유하는 개인정보 항목을 명시하여 고지한 경우 등은 이용자의 개인정보를 보관할 수 있습니다.

 

▶ 개인정보 수집 및 이용 동의 거부

개인정보 수집 및 이용 동의를 거부하실 수 있습니다. 다만, 이 경우 회원가입이 제한됩니다.
   </textarea>
							<h3>
								<input type="checkbox" name="c2" id="c2" />&nbsp; 
								<label for="c2">개인정보 수집 및 이용에 대한 안내(필수)</label>
							</h3>
							<div>
								<textarea readonly="readonly" rows="20" cols="120">

			▶ 봄에어클럽 개인 정보 수집 및 이용 안내
			
			[개인정보의 수집 목적 및 이용]
			봄에어항공은 서비스 제공 및 마케팅 활동을 위해 회원의 동의를 얻어 개인정보를 수집하고 있습니다.
			
			 
			
			[개인정보 수집 항목]
			가. 봄에어클럽 회원 가입 시 
			   - 필수항목 : 한글 및 영문 성명 , 성별, 전화번호, 주소, 우편번호, 이메일, 국적, 거주국가, 본인 인증번호, 아이디,비밀번호
			     - 만 14세 미만 회원 가입 시 추가 수집 항목 : 법정대리인의 성명,생년월일
			
			나. 봄에어클럽 가족회원 등록 : 가족관계를 증빙할 수 있는 서류
			
			 
			
			[개인정보의 보유 및 이용기간]
			봄에어항공은 회원이 봄에어클럽을 탈퇴하거나 자격을 상실하는 경우 또는 수집목적을 달성하거나 사업을 폐업하는 경우에는 회원DB 삭제, 문서 파기 등의 방법으로 해당 개인정보를 1일내 파기하고 있습니다. 다만, 전자상거래 등에서의 소비자보호에 관한 법률 등 관련 법령의 규정에 의하여 보존하여야 하는 기록은 일정 기간 보관 후 파기합니다. (계약 또는 청약철회 등에 관한 기록: 5년, 대금결제 및 재화 등의 공급에 관한 기록: 5년, 소비자의 불만 또는 분쟁처리에 관한 기록: 3년)
			 
			
			 
			
			▶ 홈페이지 개인정보 수집 및 이용 안내
			
			[개인정보의 수집 목적 및 이용]
			가. 서비스 제공을 위한 계약의 이행
			항공권 예약발권, 면세품 사전 주문, 콘텐츠 제공,금융거래 본인인증 및 금융서비스 등
			
			나. 회원 관리
			회원제 서비스 이용, 개인식별, 가입의사 확인, 민원처리 등
			
			다. 마케팅 및 광고 활용
			기타 새로운 서비스, 신상품이나 이벤트 정보 안내, 서비스 이용 통계 등
			
			 
			
			[개인정보 수집 항목]
			가. 항공권 예매 시
			     - 탑승자 성명, 회원번호(회원인 경우) , 생년월일(소아, 유아인 경우) , 전화번호, 이메일(선택적)
			     - 신용카드 결제( 카드번호, 거래 인증번호), 계좌이체(거래은행명, 계좌번호)
			     - 여권정보 (여권번호, 만료일, 발급처, 국적)
			
			나. 고객센터 이용 시 
			     - 성명, 연락처 , 이메일 주소(선택적), 회원번호(선택적), 생년월일(선택적), 탑승정보(선택적)
			
			다. 면세품 주문 시
			     - 주문자 성명(또는 회원 성명), 탑승자 성명, 회원번호 또는 생년월일, 연락 전화번호, 이메일 주소, 카드번호 및 카드 인증 정보, 포인트 상품 배송 주소
			※ 비회원의 경우 기내면세품 전달을 위해 봄에어항공은 성명, 생년월일, 탑승편 정보 등 필요한 최소한의 정보만을 수집합니다.
			
			라. 이벤트 응모 시
			     - 이벤트 응모 과정에서 회원 가입 시 수집하지 않았던 개인정보를 추가로 수집할 때에는 이용자들에게 고지하고 동의를 받습니다.
			
			마. 자동으로 생성되는 개인정보 
			     - 서비스 이용기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록
			
			 
			
			[개인정보의 보유 및 이용기간]
			가. 이용자가 제공한 개인정보는 봄에어항공이 제공하는 서비스를 받는 동안 봄에어항공이 보유ㆍ이용하게 됩니다.
			
			나. 봄에어클럽의 개인정보의 보유 기간 및 파기 절차는 봄에어클럽 개인정보취급방침에 따릅니다.
			
			다. 전자상거래등에서의 소비자보호에 관한 법률 등 관계법령의 규정에 의하여 보존하여야 하는 기록은 일정 기간 보관 후 파기합니다.
			     - 계약 또는 청약철회 등에 관한 기록 (보존기간 : 5년) : 전자상거래 등에서의 소비자 보호에 관한 법률
			     - 대금결제 및 재화 등의 공급에 관한 기록 (보존기간 : 5년) : 전자상거래 등에서의 소비자 보호에 관한 법률
			     - 소비자의 불만 또는 분쟁처리에 관한 기록 (보존기간 : 3년) : 전자상거래 등에서의 소비자 보호에 관한 법률
			     - 홈페이지 방문에 관한 기록 (보존 기간: 3개월) : 통신비밀보호법
			     - 이벤트 참여 기록 (보존 기간 : 1년) : 당사에서 정한 기준
			     - 기타 보유 정보: 정보의 수집 및 이용 목적이 달성된 때
			
			라. 전항의 규정에도 불구하고, 상법, 전자상거래 등에서의 소비자 보호에 관한 법률 등 관계법령의 규정에 따라 보존의 필요성이 있는 경우 혹은 요금의 정산, 소송 등 법적 분쟁에 대비하기 위하여 개인정보에 대한 계속적인 보유의 필요성이 있어 보유목적, 기간, 보유하는 개인정보 항목을 명시하여 고지한 경우 등은 이용자의 개인정보를 보관할 수 있습니다.
			
			 
			
			▶ 개인정보 수집 및 이용 동의 거부
			
			개인정보 수집 및 이용 동의를 거부하실 수 있습니다. 다만, 이 경우 회원가입이 제한됩니다.
   </textarea>
							</div>
							<h5>
								<input type="checkbox" name="c3" id="c3" />&nbsp; 
								<label for="c3">위치정보 이용약관 동의(선택)</label>
							</h5>
							<div>
								<textarea readonly="readonly" rows="5" cols="120">

1. 봄에어항공은 별도의 회원동의 없이 개인정보를 제 3자에게 제공하지 않습니다.(법률에 특별한 규정이 있는 경우 제외) 다만, 회원께서 아래의 제휴서비스 이용 시 다음의 최소한의 개인정보가 제공될 수 있습니다. >>제휴사 상세 보기

 

2. 전항의 경우를 제외하고, 회원으로부터 제공받은 개인정보를 수집 목적 이외의 용도로 이용하거나 동의없이 제3자에게 제공함으로 인해 발생하는 피해에 대하여는 봄에어항공에게 책임이 있습니다. 다만, 회원이 고의나 과실로 자신의 개인정보를 유출하거나 허위의 정보를 제공한 경우 또는 개인정보에 변경이 발생하였음에도 이를 알리지 않아 불일치가 발생한 경우에는 그러하지 아니합니다.
 				</textarea>
							</div>
					</div>
				</div>
				<div class="btnRegister">
					<button class="btn btn-danger btn-lg" onclick="history.back()">뒤로</button>
					<button class="btn btn-primary btn-lg" onclick="nextBtn()">다음</button>
				</div>
			</div>
			
			<div class="row setup-content " id="step-2">
				<br>
				<h1>Step 2 : 개인정보 입력</h1>
				<hr class="hrCss">
			
				<table border="1">
					
						<tr>
							<td>
								<label class="control-label">아이디</label>
							</td>
							<td>
								<input id="id"
								name="g_id" maxlength="200" type="text" required="required"
								class="form-id" placeholder="아이디" /> <input id="idcheck" class="btn2"
								type="button" value="중복체크"><br><br>
								<span id="id_span"></span>
								<span id="id_span_fail"></span>
							</td>
						</tr>
						
						<tr>
							<td>
								<label class="control-label">비밀번호</label>
							</td>
							<td>
								<div class="form-group">
									<label class="control-label">비밀번호</label><br> <input id="pwd"
										name="g_pwd" maxlength="200" type="password" required="required"
										onchange="checkpwd()" class="form-passwd" placeholder="비밀번호" />
								</div>
								<span class="form-group"> <label class="control-label">비밀번호
										재입력</label><br> <input id="rpwd" maxlength="200" type="password"
									required="required" onchange="checkpwd()" class="form-passwd"
									placeholder="비밀번호 재입력" />
								</span>
								<span id="same"></span>
							</td>
						</tr>
						
						<tr>
							<td>
								<label class="control-label">이름</label>
							</td>
							<td>
								<input name="g_name" maxlength="200" type="text" required="required"
								class="form-control" placeholder="이름" />
							</td>
						</tr>
						
						<tr>
							<td>
								<label class="control-label">생년월일</label><br>
							</td>
							<td>
								<input name="g_birth" maxlength="200" type="date" required="required"
									class="form-control" placeholder="생년월일" />
							</td>
						</tr>
						
						<tr>
							<td>
								<label class="control-label">거주지</label>
							</td>
							<td>
								<input type="text" id="postcode" placeholder="우편번호"> 
								<input type="button" class="btn2" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
								<input type="text" id="address" onkeyup="addradd()"
									placeholder="주소"><br> <input type="text"
									id="extraAddress" placeholder="참고항목"> <input type="text"
									id="detailAddress" onkeyup="addradd()" placeholder="상세주소"
									autocomplete="false"> 
								<input type="hidden" id="g_addr" name="g_addr">
							</td>
						</tr>
						
						<tr>
							<td>
								<label class="control-label">휴대전화</label>
							</td>
							<td>
								<select id="g_tel1" class="form-control2">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>&nbsp;-&nbsp; 
								<input id="g_tel2" maxlength="4" type="text" 
									pattern="\d{3,4}" class="form-control2" required="required" />&nbsp;-&nbsp;
								<input id="g_tel3" maxlength="4" type="text" pattern="\d{4}"
									class="form-control2" required="required" /> 
								<input type="hidden" id="g_tel" name="g_tel">
							</td>
						</tr>
						
						<tr>
							<td>
								<label class="control-label">이메일</label><br>
							</td>
							<td>
								<input name="g_mail" maxlength="200" type="email" required="required"
									class="form-control" placeholder="이메일" />
							</td>
						</tr>
						
					</table>
					
					<div class="btnArea">
						<button class="btn btn-primary2 nextBtn btn-lg btn2-lg" type="submit">회원가입</button>					
					</div>
			</div>
				
			
			
			
			
			<!-- 
			<div class="row setup-content " id="step-2">
				<h1>Step 2</h1>
				<br><br>
				<div class="form-group">
					<label class="control-label">아이디</label><br> 
					<input id="id"
						name="g_id" maxlength="200" type="text" required="required"
						class="form-id" placeholder="아이디" /> <input id="idcheck"
						type="button" value="중복체크"> <span id="id_span"></span> <span
						id="id_span_fail"></span>
				</div>

				<div class="form-group">
					<label class="control-label">비밀번호</label><br> <input id="pwd"
						name="g_pwd" maxlength="200" type="password" required="required"
						onchange="checkpwd()" class="form-passwd" placeholder="비밀번호" />
				</div>

				<span class="form-group"> <label class="control-label">비밀번호
						재입력</label><br> <input id="rpwd" maxlength="200" type="password"
					required="required" onchange="checkpwd()" class="form-passwd"
					placeholder="비밀번호 재입력" />
				</span>>&nbsp;&nbsp;
				<span id="same"></span>

				<div class="form-group">
					<label class="control-label">이름</label> <input name="g_name"
						maxlength="200" type="text" required="required"
						class="form-control" placeholder="이름" />
				</div>

				<div class="form-group">
					<label class="control-label">생년월일</label> 
					<input name="g_birth"
						maxlength="200" type="date" required="required"
						class="form-control" placeholder="생년월일" />
				</div>

				<!-- 여권번호 자리 

				<div class="form-group">
					<label class="control-label">우편번호</label><br> 
					<input type="text" id="postcode" placeholder="우편번호"> 
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="address" onkeyup="addradd()"
						placeholder="주소"><br> <input type="text"
						id="extraAddress" placeholder="참고항목"> <input type="text"
						id="detailAddress" onkeyup="addradd()" placeholder="상세주소"
						autocomplete="false"> 
					<input type="hidden" id="g_addr" name="g_addr">
				</div>

				<div class="form-group">
					<label class="control-label">휴대전화</label> &nbsp; 
					<select id="g_tel1" class="form-control2">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>&nbsp;-&nbsp; 
					<input id="g_tel2" maxlength="4" type="text" 
						pattern="\d{3,4}" class="form-control2" required="required" />&nbsp;-&nbsp;
					<input id="g_tel3" maxlength="4" type="text" pattern="\d{4}"
						class="form-control2" required="required" /> 
					<input type="hidden" id="g_tel" name="g_tel">
				</div>

				<div class="form-group">
					<label class="control-label">이메일</label> 
					<input name="g_mail" maxlength="200" type="email" required="required"
						class="form-control" placeholder="이메일" />
				</div>
				
			</div>
			-->
			
			
		</form>
	</div>
</body>
</html>