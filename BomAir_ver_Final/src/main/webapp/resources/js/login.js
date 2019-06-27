$(function() {
	$(".showAlert").hide();

	$(".btnGoMain").click(function() {
		location.href = "index";
	});
})

function showAlertMessage() {
	$(".showAlert").show();
}

function confirmLogout() {
	if (confirm("정말 로그아웃 하시겠습니까?")) {
		location.href = "logout";
	}
}

function find_id() {
	$('#id_myModal').show();
}

function find_pwd() {
	$('#pwd_myModal').show();
}

function close_pop() {
	$('#id_myModal').hide();
	$('#pwd_myModal').hide();
}

$(document).ready(
		function() {
			$("#id_find").on(
					"click",
					function() {
						$.ajax({
							type : "post",
							url : "find_id",
							data : {
								"name" : $("#find_name").val(),
								"tel" : $("#find_g_tel1").val() + "-"
										+ $("#find_g_tel2").val() + "-"
										+ $("#find_g_tel3").val()
							},
							dataType : "json",
							success : function(data) {
								var str = "<table><tr><th>계정</th></tr>";
								if (data.length == 0) {
									str += "<tr><td>계정없음</td></tr>";
								} else {
									for (var i = 0; i < data.length; i++) {
										str += "<tr><td>" + data[i].id
												+ "</td></tr>";
									}
								}
								str += "</table>";
								$("#find_id_content").html(str);
							},
							error : function() {
								alert("에러발생");
							}
						});
					})
		});

$(document).ready(
		function() {
			$("#pwd_find").on(
					"click",
					function() {
						$.ajax({
							type : "post",
							url : "find_pwd",
							data : {
								"name" : $("#find_pwd_name").val(),
								"tel" : $("#find_pwd_g_tel1").val() + "-"
										+ $("#find_pwd_g_tel2").val() + "-"
										+ $("#find_pwd_g_tel3").val(),
								"id" : $("#find_pwd_id").val()
							},
							dataType : "json",
							success : function(data) {
								if(data.result=="true"){
									alert("메일이 성공적으로 발송되었습니다.");
								}else{
									alert("등록된 정보가 없습니다.");
								}
							},
							error : function() {
								alert("등록된 정보가 없습니다.");
							}
						});
					})
		});