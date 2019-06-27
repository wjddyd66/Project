<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/mybook.css">
</head>
<body class="basicFont container">
<div class="logo"><a href="index.jsp"><img src="resources/images/bomair_logo.png"/></a></div>
<br><br><br>
* 도시 항공노선 정보 입력 * <p/>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.0.min.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
  $('#btn_go').click(function(){
		var aa = $('#month').val();
		var bb = $('#year').val();
		$('input[name=o_sdate]').attr('value', bb+'-'+aa+'-01');
		
		if($('#l_code').val() === ''){
			alert("도시를 입력해주세요");
		}else if(bb === ''){
			alert("년도를 입력해주세요");				
		}else if(aa === ''){
			alert("월을 입력해주세요");				
		}else{
			
		if($('#l_code').val() === 'CJU'){
		$('input[name=o_soyo]').attr('value','70');
		//var bb = $('#o_sdate').val();
		//alert(bb);
		}else if($('#l_code').val() === 'NPT'){
			$('input[name=o_soyo]').attr('value','135');			
		}else if($('#l_code').val() === 'KIX'){
			$('input[name=o_soyo]').attr('value','95');			
		}else if($('#l_code').val() === 'FUK'){
			$('input[name=o_soyo]').attr('value','80');			
		}else if($('#l_code').val() === 'HKG'){
			$('input[name=o_soyo]').attr('value','220');			
		}else if($('#l_code').val() === 'BKK'){
			$('input[name=o_soyo]').attr('value','350');			
		}else if($('#l_code').val() === 'BKI'){
			$('input[name=o_soyo]').attr('value','410');			
		}else if($('#l_code').val() === 'WO'){
			$('input[name=o_soyo]').attr('value','270');			
		}else if($('#l_code').val() === 'JFK'){
			$('input[name=o_soyo]').attr('value','995');			
		}	
		alert($('#l_code').val() + "공항 " +  bb + "년 " + aa + "월의 db추가가 완료 되었습니다");

  		$("form:first").submit();
		}
  });
  
});
</script>

<form action="insert" method="post">
<!-- 
노선코드 : <input type="text" name="l_code" id="l_code"><br>
 -->

도시선택 : <select name="l_code" id=l_code>
    <option value="">도시선택</option>
    <option value="CJU">제주도</option>
    <option value="NPT">도쿄</option>
    <option value="KIX">오사카</option>
    <option value="FUK">후쿠오카</option>
    <option value="HKG">홍콩</option>
    <option value="BKK">방콕</option>
    <option value="BKI">코타키나발루</option>
    <option value="WO">블라디보스토크</option>
    <option value="JFK">뉴욕</option>
</select><br>

년 : <input type="text" name="year" id="year" value="2019"><br>
월 : <input type="text" name="month" id="month"><br>
<input type="hidden" name="air_name">
<input type="hidden" name="o_sdate" id="o_sdate">
<input type="hidden" name="o_price"><br>
<input type="hidden" name="o_soyo" id="o_soyo">
<input type="hidden" name="o_stime">


<br>
<input type="button" value="추가" id="btn_go" >
<a href="list">리스트보기</a>
</form>

<br><br><br>
<hr class="hrCss">
<br>
------------------------ 노선 정보 ---------------------<br>
제주(CJU)<br>
도쿄(NPT)<br>
오사카(KIX)<br>
후쿠오카(FUK)<br>
홍콩(HKG)<br>
방콕(BKK)<br>
코타키나발루(BKI)<br>
블라디보스토크(WO)<br>
뉴욕(JFK)

</body>
</html>