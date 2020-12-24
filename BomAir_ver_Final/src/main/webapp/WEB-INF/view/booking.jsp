<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html style="height: 100%; width: 100%;">
<head>
<link rel="stylesheet" href="resources/css/bookingstyle.css">
<!-- Bootstrap -->
<%@include file="/bootstrap.jsp"%>
<!-- CSS -->

<!-- Modernizr -->
<meta charset="UTF-8">
<title>항공권 예매</title>

</head>
<%@include file="/header.jsp"%>
<body>

   <div align="center"
      style="align-content: center; width: 100%; height: 100%;">
      <form class="cd-form floating-labels">

         <fieldset>
            <legend id="siteName" style="text-align: left;">항공권 예매</legend>
            <div id="siteMap" align="center">
               <ul>
                  <li id="homeli"><span><a href="index"><img
                           src="resources/images/houselogo.png">홈</a></span></li>
                  <li><span>항공권 예매</span></li>
                  <li><span>항공권</span></li>
                  <li><span>항공권 예매</span></li>
               </ul>



            </div>
            <div style="height: 50px; margin-bottom: 20px;">
               <ul class="cd-form-list" id="way">
                  <li><input type="radio" name="flightWay" id="cd-radio-1"
                     value="round" checked> <label for="cd-radio-1">왕복</label></li>

                  <li><input type="radio" name="flightWay" id="cd-radio-2"
                     value="one_way"> <label for="cd-radio-2">편도</label></li>
               </ul>

            </div>

            <div id="div1">
               <div class="divaa" style="margin-right: 20px; height: 20%;">

                  <label>출발지 선택 </label> <select class="selectOptions" id="Depart">
                     <option>출발지 선택</option>
                     <option value="inc" style="width: 100%">인천(INC)</option>
                  </select> <br> <label>목적지 선택 </label> <select class="selectOptions"
                     id="Arrive">
                     <option>목적지 선택</option>
                     <optgroup label="국내">
                        <option value="CJU" style="width: 100%">제주(CJU)</option>
                     </optgroup>
                     <optgroup label="일본">
                        <option value="NPT" style="width: 100%">도쿄(NPT)</option>
                        <option value="KIX" style="width: 100%">오사카(KIX)</option>
                        <option value="FUK" style="width: 100%">후쿠오카(FUK)</option>
                     </optgroup>
                     <optgroup label="동남아">
                        <option value="HKG" style="width: 100%">홍콩(HKG)</option>
                        <option value="BKK" style="width: 100%">방콕(BKK)</option>
                        <option value="BKI" style="width: 100%">코타키나발루(BKI)</option>
                     </optgroup>
                     <optgroup label="그외 지역">
                        <option value="WO" style="width: 100%">블라디보스토크(WO)</option>
                        <option value="JFK" style="width: 100%">뉴욕(JFK)</option>
                     </optgroup>
                  </select> <br>
               </div>

               <div class="divaa"
                  style="padding-right: 20px; border-right: 5px dotted #ecf0f1">
                  <label>가는날 선택 </label> <input type="text" class="testDatepicker"
                     id="GoDateChoose" style="width: 100%" placeholder="출발 날짜 선택">
                  <br>
                  <div id="backDate">
                     <label>오는날 선택 </label> <input type="text" class="testDatepicker"
                        id="BackDateChoose" style="width: 100%" placeholder="복귀 날짜 선택">
                     <br>
                  </div>
               </div>

               <div class="divaa" style="padding-left: 50px">
                  <label>탑승 인원 </label> <input type="text" id="people" name="people"
                     placeholder="인원수" style="width: 100%" data-toggle="modal"
                     data-target="#myModal" readonly="readonly">
               </div>
               <br>
            </div>
            <div class="modal" id="myModal" tabindex="-1" role="dialog">
               <div class="modal-dialog modal-sm">
                  <div class="modal-content">
                     <div class="modal-body">
                        성인: <input type="button" id="decAd" value="▽"><span
                           id="numberUpDown1">1</span><input type="button" id="incAd"
                           value="△"><br> <br>소아: <input type="button"
                           id="decCh" value="▽"><span id="numberUpDown2">0</span><input
                           id="incCh" type="button" value="△"><br> <br>유아:
                        <input type="button" id="decBa" value="▽"><span
                           id="numberUpDown3">0</span><input id="incBa" type="button"
                           value="△"><br>
                        <hr>
                        <b>소아</b> : 국내선 만 2세~만12세<Br> 국제선 만 2세~만11세<br> <b>유아</b>
                        : 만2세 미만<br>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn" id="inwonOk">확인</button>
                        <button type="button" class="btn" data-dismiss="modal"
                           id="inwonClose">닫기</button>
                     </div>
                  </div>
               </div>
            </div>

         </fieldset>
         <div class="btnSubmit" align="center"
            style="text-align: center;">
            
            <input type="button" class = "booksubmit" id = "reservationsubmit" value = "일정으로 조회">
         </div>

      </form>
   </div>


   <!-- Resource jQuery -->
   <%@include file="/bottom.jsp"%>
   <form action="airinfo" method="post" id="O_frm">
      <input type="hidden" name="l_code"> <input type="hidden"
         name="o_sdate"> <input type="hidden" name="people">
   </form>

   <form action="airinfo_R" method="post" id="R_frm">
      <input type="hidden" name="l_code"> <input type="hidden"
         name="o_sdate"> <input type="hidden" name="o_sdate_R">
      <input type="hidden" name="people">
   </form>
</body>
</html>