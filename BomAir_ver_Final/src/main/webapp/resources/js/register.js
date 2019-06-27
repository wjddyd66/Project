$(document)
		.ready(
				function() {

					var navListItems = $('div.setup-panel div a'), allWells = $('.setup-content'), allNextBtn = $('.nextBtn');

					allWells.hide();

					navListItems.click(function(e) {
						e.preventDefault();
						var $target = $($(this).attr('href')), $item = $(this);

						if (!$item.hasClass('disabled')) {
							navListItems.removeClass('btn-primary').addClass(
									'btn-default');
							$item.addClass('btn-primary');
							allWells.hide();
							$target.show();
							$target.find('input:eq(0)').focus();
						}
					});

					allNextBtn
							.click(function() {
								var curStep = $(this).closest(".setup-content"), curStepBtn = curStep
										.attr("id"), nextStepWizard = $(
										'div.setup-panel div a[href="#'
												+ curStepBtn + '"]').parent()
										.next().children("a"), curInputs = curStep
										.find("input[type='text'],input[type='url']"), isValid = true;

								$(".form-group").removeClass("has-error");
								for (var i = 0; i < curInputs.length; i++) {
									if (!curInputs[i].validity.valid) {
										isValid = false;
										$(curInputs[i]).closest(".form-group")
												.addClass("has-error");
									}
								}

								if (isValid)
									nextStepWizard.removeAttr('disabled')
											.trigger('click');
							});

					$('div.setup-panel div a.btn-primary').trigger('click');

					$("#g_tel3").change(
							function() {
								$("#g_tel").val(
										$("#g_tel1").val() + "-"
												+ $("#g_tel2").val() + "-"
												+ $("#g_tel3").val())
								// alert($("#g_tel").val());
							})

				});

var element_layer = document.getElementById('layer');

function closeDaumPostcode() {
	element_layer.style.display = 'none';
}

function execDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
			
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			if (data.userSelectedType === 'R') {
				addr = data.roadAddress;
			} else {
				addr = data.jibunAddress;
			}

			if (data.userSelectedType === 'R') {

				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}

				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName
							: data.buildingName);
				}

				if (extraAddr !== '') {
					extraAddr = ' (' + extraAddr + ')';
				}

				document.getElementById("extraAddress").value = extraAddr;

			} else {
				document.getElementById("extraAddress").value = '';
			}

			document.getElementById('postcode').value = data.zonecode;
			document.getElementById("address").value = addr;
			//추가
			document.getElementById("detailAddress").value='';
			
			document.getElementById("detailAddress").focus();

			element_layer.style.display = 'none';
		},
		width : '100%',
		height : '100%',
		maxSuggestItems : 5
	}).embed(element_layer);

	// iframe을 넣은 element를 보이게 한다.
	element_layer.style.display = 'block';
	initLayerPosition();
}

function initLayerPosition() {
	var width = 300;
	var height = 400;
	var borderWidth = 5;

	element_layer.style.width = width + 'px';
	element_layer.style.height = height + 'px';
	element_layer.style.border = borderWidth + 'px solid';
	element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
			+ 'px';
	element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
			+ 'px';
}

function addradd() {
	if (document.getElementById("address").value !== null
			&& document.getElementById("detailAddress").value !== null) {
		document.getElementById("g_addr").value = document
				.getElementById("address").value
				+ document.getElementById("detailAddress").value;
		// alert(document.getElementById("g_addr").value);
	}
}

function checkpwd() {
	var pwd = document.getElementById("pwd").value;
	var rpwd = document.getElementById("rpwd").value;

	if (pwd !== "" && rpwd !== "") {
		if (pwd === rpwd) {
			document.getElementById('same').innerHTML = '비밀번호가 일치합니다.';
			document.getElementById('same').style.color = 'blue';
			document.getElementsByName("g_pwd").value = pwd;
			// alert("입력된 비밀번호"+document.getElementsByName("g_pwd").value);
		} else {
			document.getElementById('same').innerHTML = '비밀번호가 일치하지 않습니다.';
			document.getElementById('same').style.color = 'red';
		}
	}
}

function nextBtn() {
	if (document.getElementById("c1").checked === false
			|| document.getElementById("c2").checked === false) {
		alert("필수 약관 동의를 체크해주세요.");
		var offset = $("#step-1").offset();
		$('html, body').animate({
			scrollTop : offset.top
		}, 400);

	} else {
		$("#btn1").attr('class', 'btn btn-default btn-circle');
		$("#btn2").attr('class', 'btn btn-primary btn-circle');
		$("#btn2").attr('disabled', false);

		$("#step-1").hide();
		$("#step-2").show();
		// document.getElementById("g_id").focus();
	}
}

var deny = 't';
$(document).ready(function() {
	$("#idcheck").on("click", function() {
		$.ajax({
			type : "get",
			url : "id_check",
			data : {
				"id" : $("#id").val()
			},
			dataType : "json",
			success : function(data) {
				if (data.Check === "success") {
					$("#id_span_fail").hide();
					$("#id_span").text("사용가능한 아이디입니다.");
					$("#id_span").show();

				} else if (data.Check === "fail") {
					$("#id_span").hide();
					$("#id_span_fail").text("아이디가 중복되었습니다.");
					$("#id_span_fail").show();
				}

				if (data.Check2 === "deny") {
					deny = 'f';
				}
			},
			error : function() {
				alert("에러발생");
			}
		});
	});
});

function check() {
	if (deny === 'f') {
		alert("아이디가 중복되었습니다.");
		deny = 't';
		return false;
	} else if (document.getElementById("pwd").value !== document
			.getElementById("rpwd").value) {
		alert("비밀번호가 다릅니다.");
		return false;
	} else {
		return true;
	}
}
