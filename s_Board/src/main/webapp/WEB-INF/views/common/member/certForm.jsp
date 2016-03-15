<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<tiles:insertDefinition name="index">
<tiles:putAttribute name="body">
	<script type="text/javascript">
		$(document).ready(function() {
			$("#reCertCheckBtn").click(function() {
				var msg = confirm('이메일 인증하시겠습니까? 최대 1분 소요됩니다.');
				if (msg) {
					$.ajax({
						type : "post",
						url : "/s_Board/email/send",
						data : {
							"receiver1" : "${receiver1}",
							"receiver2" : "${receiver2}"
						},
						dateType : "json",
						success : function(json) {
						}
					});
				} else {
					console.log("else!!")
					//location.href="../main/index";
				}
			});
			$("#certCheckBtn").click(function() {
				var serialize = $("#certForm").serialize();
				$.ajax({
		            type : "post",
		            url : "/s_Board/email/cert",
		            dataType : "json",
		            data : serialize,
		            success : function(jsonObj) {
		            	if(jsonObj.isCheck){
							console.log("success 인증완료");
							//$.post("/s_Board/joinForm", {"receiver1" : "${receiver1}", "receiver2" : "${receiver2}"});
							$("#certForm").submit();
							/* $.ajax({
								type : "post",
								url : "/s_Board/joinForm",
								data : {
									"receiver1" : "${receiver1}",
									"receiver2" : "${receiver2}"
								},
								dataType : "json",
								success : function(json){
									console.log("true");
									console.log(json);
								},
								error : function(err){
									console.log(err)
								}
							}) */
						} else {
							alert('인증번호가 잘못입력되었습니다');
							console.log("인증번호가 잘못되었습니다");
						}
		            },
		            error : function(err) {
		            	console.log(err);
		            }
		         });
			});
		});
	</script>
	<div id="content">
		<div class="container">
			<!-- Sign Up form -->

			<form class="form-login form-wrapper form-medium" role="form" id="certForm" style="max-width: 400px;" method="post" action="/s_Board/joinForm">
				<h3 class="title-divider">
					<span>Certification Number</span> <small>Already signed	up? <a href="login.htm">Login here</a>.
					</small>
				</h3>

				<h5>${receiver1}@${receiver2}</h5>
				

				<table>
					<colgroup>
						<col style="width: 10%;">
						<col style="width: 40%;">
						<col style="width: auto;">
					</colgroup>
					<tbody>
						<tr>
							<td>인증번호</td>
							<td><input type="text" class="form-control" id="certNumber" placeholder="인증번호 4자리" name="certNumber" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')">
							</td>
							<td>
								<button class="btn btn-primary" type="button" id="reCertCheckBtn">재전송</button>
							</td>
						</tr>

						<tr>
							<td>
								<button class="btn btn-primary" type="button" id="certCheckBtn">완 료</button>
							</td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" name="receiver1" value="${receiver1}">
				<input type="hidden" name="receiver2" value="${receiver2}">
			</form>
		</div>
	</div>
</tiles:putAttribute>
</tiles:insertDefinition>