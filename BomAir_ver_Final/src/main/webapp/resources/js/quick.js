$(document).ready(
		function() {
			$.ajax({
				type : "get",
				url : "gong_main",
				dataType : "json",
				success : function(data) {
					var str="";
					for(var i=0;i<data.length;i++){
						str+="<li><a href='gong_detail?num="+data[i].num+"&spage=1' class='float-left'>"
							+ data[i].title + "</a><br><p>" + data[i].con
							+ "</p></li>"
					}
					$("#gonggi_content").html(str);
				},
				error : function() {
					alert("에러발생");
				}
			});
			
			
			
			/* 항공권, 렌트카에 따라 테이블 보이기 */
			$("input[name='reservation']").click(function() {
				$("#reservation-table").show();
				$("#rent-table").hide();
				$("#searchHang").show();
				$("#searchRent").hide();

			});

			$("input[name='rent']").click(function() {
				$("#rent-table").show();
				$("#reservation-table").hide();
				$("#searchRent").show();
				$("#searchHang").hide();
			});

			$("input[name='flightWay']").click(function() {
				if ($("input[name='flightWay']:checked").val() == 'round') {
					$("#backDate").show();
					$("#goDate").css('width', '50%');
					$("#goDate").attr('colspan', '1');
				} else {
					$("#backDate").hide();
					$("#goDate").css('width', '100%');
					$("#goDate").attr('colspan', '2');
				}

			});

			/* 날짜 선택 */
			$("#GoDateChoose").datepicker(
					{
						changeMonth : true,
						changeYear : true,
						nextText : '다음 달',
						prevText : '이전 달',
						showButtonPanel : true,
						currentText : '출발 날짜',
						closeText : '닫기',
						dateFormat : "yymmdd",
						minDate : -0,
						maxDate : 1000,
						dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
						monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7',
								'8', '9', '10', '11', '12' ],
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ]

					});

			$("#BackDateChoose").datepicker(
					{
						changeMonth : true,
						changeYear : true,
						nextText : '다음 달',
						prevText : '이전 달',
						showButtonPanel : true,

						currentText : '도착 날짜',
						closeText : '닫기',
						dateFormat : "yymmdd",
						minDate : -0,
						maxDate : 1000,
						dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
						monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7',
								'8', '9', '10', '11', '12' ],
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ]

					});

			$("#RentDateChoose").datepicker(
					{
						changeMonth : true,
						changeYear : true,
						nextText : '다음 달',
						prevText : '이전 달',
						showButtonPanel : true,
						currentText : '출발 날짜',
						closeText : '닫기',
						dateFormat : "yymmdd",
						minDate : -0,
						maxDate : 1000,
						dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
						monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7',
								'8', '9', '10', '11', '12' ],
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ]

					});

			$("#ReturnDateChoose").datepicker(
					{
						changeMonth : true,
						changeYear : true,
						nextText : '다음 달',
						prevText : '이전 달',
						showButtonPanel : true,

						currentText : '도착 날짜',
						closeText : '닫기',
						dateFormat : "yymmdd",
						minDate : -0,
						maxDate : 1000,
						dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
						monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7',
								'8', '9', '10', '11', '12' ],
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ]

					});
			$("#GoDateChoose").change(
					function() {
						if ($("#GoDateChoose").val() > $("#BackDateChoose")
								.val()
								&& $("#BackDateChoose").val() != '') {
							alert("출발일은 도착일보다 늦을 수 없습니다.");
							$("#GoDateChoose").val('');
						}
					});

			$("#RentDateChoose").change(
					function() {
						if ($("#RentDateChoose").val() > $("#ReturnDateChoose")
								.val()
								&& $("#ReturnDateChoose").val() != '') {
							alert("출발일은 도착일보다 늦을 수 없습니다.");
							$("#RentDateChoose").val('');
						}
					});

			$("#BackDateChoose").change(function() {
				if ($("#GoDateChoose").val() > $("#BackDateChoose").val()) {
					alert("도착일은 출발일보다 빠를수 없습니다.");
					$("#BackDateChoose").val('');
				}
			});

			$("#ReturnDateChoose").change(function() {
				if ($("#RentDateChoose").val() > $("#ReturnDateChoose").val()) {
					alert("반납일은 렌트일보다 빠를수 없습니다.");
					$("#ReturnDateChoose").val('');
				}
			});

			/* 탑승 인원 늘리기/줄이기 */
			$('#decAd').click(function(e) {
				e.preventDefault();

				var num2 = $('#numberUpDown1').text();
				var num1 = parseInt(num2);
				num1--;
				if (num1 <= 0) {
					alert('더이상 줄일수 없습니다.');
					num1 = 1;
				} else {
					$('#numberUpDown1').text(num1);
				}
			});

			$('#incAd').click(function(e) {
				e.preventDefault();
				var num2 = $('#numberUpDown1').text();
				var num1 = parseInt(num2);
				num1++;
				if (num1 >= 10) {
					alert('더이상 늘릴수 없습니다.');
					num1 = 9;
				} else {
					$('#numberUpDown1').text(num1);
				}
			});

			$('#decCh').click(function(e) {
				e.preventDefault();

				var num2 = $('#numberUpDown2').text();
				var num1 = parseInt(num2);
				num1--;
				if (num1 < 0) {
					alert('더이상 줄일수 없습니다.');
					num1 = 0;
				} else {
					$('#numberUpDown2').text(num1);
				}
			});
			$('#incCh').click(function(e) {
				e.preventDefault();
				var num2 = $('#numberUpDown2').text();
				var num1 = parseInt(num2);
				num1++;
				if (num1 >= 10) {
					alert('더이상 늘릴수 없습니다.');
					num1 = 9;
				} else {
					$('#numberUpDown2').text(num1);
				}
			});

			$('#decBa').click(function(e) {
				e.preventDefault();

				var num2 = $('#numberUpDown3').text();
				var num1 = parseInt(num2);
				num1--;
				if (num1 < 0) {
					alert('더이상 줄일수 없습니다.');
					num1 = 0;
				} else {
					$('#numberUpDown3').text(num1);
				}
			});
			$('#incBa').click(function(e) {
				e.preventDefault();
				var num2 = $('#numberUpDown3').text();
				var num1 = parseInt(num2);
				num1++;
				if (num1 >= 10) {
					alert('더이상 늘릴수 없습니다.');
					num1 = 9;
				} else {
					$('#numberUpDown3').text(num1);
				}
			});

			// 모달 값 설정
			$('#inwonOk').click(function(e) {
				e.preventDefault();
				var num1 = $('#numberUpDown1').text();
				var adNum = "성인: " + parseInt(num1);

				var num2 = $('#numberUpDown2').text();
				var chNum = parseInt(num2);
				if (chNum == 0) {
					chNum = "";
				} else {
					chNum = ", 소아: " + parseInt(num2);
				}

				var num3 = $('#numberUpDown3').text();
				var baNum = parseInt(num3);
				if (baNum == 0) {
					baNum = "";
				} else {
					baNum = ", 유아: " + parseInt(num2);
				}

				$('#people').val(adNum + chNum + baNum);
				$('#inwonClose').click();
			});

			/* '일정으로 조회하기' 클릭 이벤트 */
			$("#reservationsubmit").click(function() {

		if ($("input[name='flightWay']:checked").val() === 'round'){
			
			$('input[name=l_code]').attr('value', $('#Arrive').val());
			
			var o_sdate = $('#GoDateChoose').val();
			var o_sdate1 = o_sdate.substring(0,4) + "-" + o_sdate.substring(4,6) + "-" + o_sdate.substring(6,8);
			$('input[name=o_sdate]').attr('value', o_sdate1);
			
			var o_sdate_R = $('#BackDateChoose').val();
			var o_sdate_R1 = o_sdate_R.substring(0,4) + "-" + o_sdate_R.substring(4,6) + "-" + o_sdate_R.substring(6,8);
			$('input[name=o_sdate_R]').attr('value', o_sdate_R1);
			
			var people = $('#people').val();
			var people1 = people.substring(4,5);
			$('input[name=people]').attr('value', people1);
			$("#R_frm").submit();
			
			
		   
		}else if($("input[name='flightWay']:checked").val() === 'one_way'){
		
			$('input[name=l_code]').attr('value', $('#Arrive').val());
			
			var o_sdate = $('#GoDateChoose').val();
			var o_sdate1 = o_sdate.substring(0,4) + "-" + o_sdate.substring(4,6) + "-" + o_sdate.substring(6,8);
			$('input[name=o_sdate]').attr('value', o_sdate1);

			
			var people = $('#people').val();
			var people1 = people.substring(4,5);
			$('input[name=people]').attr('value', people1);
			$("#O_frm").submit();
				}
								

			});

			$("#rentsubmit").click(function() {
				var RentPlaceTd = $('#RentPlaceTd option:selected').val();
				var RentDateChoose_imsi=$('#RentDateChoose').val();
				var RentDateChoose = RentDateChoose_imsi.substring(0,4) + "-" + RentDateChoose_imsi.substring(4,6) + "-" + RentDateChoose_imsi.substring(6,8);
				var ReturnDateChoose_imsi= $('#ReturnDateChoose').val();
				var ReturnDateChoose = ReturnDateChoose_imsi.substring(0,4) + "-" + ReturnDateChoose_imsi.substring(4,6) + "-" + ReturnDateChoose_imsi.substring(6,8);
				$("#aa").val(RentPlaceTd);
				$("#bb").val(RentDateChoose);
				$("#cc").val(ReturnDateChoose);
				$("#frm").submit();
			});

			$(window).scroll(function() {
				if ($(this).scrollTop() > 50) {
					$('#back-to-top').fadeIn();
				} else {
					$('#back-to-top').fadeOut();
				}
			});
			// scroll body to 0px on click
			$('#back-to-top').click(function() {
				$('body,html').animate({
					scrollTop : 0
				}, 800);
				return false;
			});
		});
