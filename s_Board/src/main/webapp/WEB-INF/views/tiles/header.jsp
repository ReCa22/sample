<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<style>
#receiver1, #receiver2, #sId, #sEmail1, #sEmail2
{
width: 47%;
}
#receiver3, #sEmail3
{
width: 47%;
height: 35px;
}
#receiver2 {
    float: right;
    margin-right: 6px;
}
#sEmail2 {
    float: right;
    margin-right: 2%;
}
</style>
<script type="text/javascript">

$(document).ready(function() {
	$("#emailBtn").click(function() {
		var receiver1 = $("#receiver1").val();
		var isReceiver1 = true;
		var regExp =/^([\w-]+(?:\.[\w-]+)*)$/;
		if(regExp.test(receiver1) == true){
			isReceiver1 = false;
		}else{
			$("#receiver1").val('');
			alert('이메일형식 앞자리가 알맞지 않습니다');
		}
		var receiver2 = $("#receiver2").val();
		var isReceiver2 = true;
		var regExp2 =/((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		if(regExp2.test(receiver2) == true){
			isReceiver2 = false;
		}else{
			$("#receiver2").val($("#receiver3").val());
			alert('이메일형식 뒷자리가 알맞지 않습니다.');
		}
		if(!isReceiver1 && !isReceiver2){
		var msg = confirm('이메일 인증하시겠습니까? 최대 1분 소요됩니다.');
		if(msg){
			$.ajax({
					type:"post",
					url:"/s_Board/email/send",
					data: {"receiver1" : $("#receiver1").val(), "receiver2" : $("#receiver2").val()},
					dateType : "json",
					success: function(json){
						console.log(json);
						if(json.result){
							var msg = confirm("인증페이지로 이동하시겠습니까?");
							if(msg){
								$("#signContents").attr("value",json.content);
								$("#signForm").submit();
							}
						}else{
							alert("잠시 후 다시 시도해주세요");
						}
					}
				})
		 }else{
			 console.log("else!!");
		 }
		}
	});
	$("#receiver1").on("keydown", function() {
		text = $(this)
		lengthCnt = $(this).val().length+1;
		if(lengthCnt == 20){
			alert("20자 이내로 작성하셔야 합니다");
			text.val('');
			
		}
		
	})
	$("#receiver2").on("keydown", function() {
		text = $(this)
		lengthCnt = $(this).val().length+1;
		if(lengthCnt == 20){
			alert("20자 이내로 작성하셔야 합니다");
			text.val('');
			
		}
		
	})
	$("#receiver3").click(function() {
		text = $(this).val();
		console.log(text);
		$("#receiver2").val(text);
		
	});
	$("#logBtn").click(function() {
		var serialize = $("#loginForm").serialize();
		$.ajax({
			type : "post",
			url : "/s_Board/login",
			data : serialize,
			dataType : "json",
			success : function(json) {
				console.log(json);
				if(json.check){
					$.ajax({
						type : "post",
						url : "/s_Board/loginOk",
						data : serialize,
						dataType : "json",
						success : function(){
							console.log("loginOk");
							location.href = "/s_Board/index";
						},
						error : function(err){
							console.log("err");
							console.log(err);
						}
					});
				}
			},
			error : function(err){
				console.log("err");
				console.log(err)
			}
		});
	});
	$("#searchBtn").click(function() {
		var sEmail1 = $("#sEmail1").val();
		var issEmail1 = true;
		var regExp =/^([\w-]+(?:\.[\w-]+)*)$/;
		if(regExp.test(sEmail1) == true){
			issEmail1 = false;
		}else{
			$("#sEmail1").val('');
			alert('이메일형식 앞자리가 알맞지 않습니다');
		}
		var sEmail2 = $("#sEmail2").val();
		var issEmail2 = true;
		var regExp2 =/((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		if(regExp2.test(sEmail2) == true){
			issEmail2 = false;
		}else{
			$("#sEmail2").val($("#sEmail3").val());
			alert('이메일형식 뒷자리가 알맞지 않습니다.');
		}
		isIdLeng = false;
		if($("#sId").val().length > 2){
			isIdLeng = true;
		}else{
			alert("아이디를 확인해 주세요");
		}
		if(!issEmail1 && !issEmail2 && isIdLeng){
			$.ajax({
				type:"post",
				url:"/s_Board/email/pwSearch",
				data: {"id" : $("#sId").val(), "address" : $("#sEmail1").val(), "address_etc" : $("#sEmail2").val()},
				dateType : "json",
				success: function(json){
					console.log(json);
					console.log(json.isCheck);
					if(json.isCheck){
						alert("e-mail로 비밀번호를 발송하였습니다");
					}else{
						alert("ID와 EMAIL 정보가 일치하지 않습니다.");
					}
				}
			});
		}
	})
});
function logout(){
	console.log('logout');
	location.href = "/s_Board/logout";
}
</script>
<!-- ======== @Region: #navigation ======== -->
<div id="navigation" class="wrapper">
      <div class="navbar-static-top">
        
        <!--Header upper region-->
        <div class="header-upper">
          <div class="header-upper-inner container">
            <div class="row">
              <div class="col-xs-8 col-xs-push-4">
                
              </div>
              <div class="col-xs-4 col-xs-pull-8">
                
             <!--user menu-->
                <div class="btn-group user-menu">
                  <!-- <a href="#login-modal" class="btn btn-link login-mobile"><i class="fa fa-user"></i></a> -->
                  <%-- <c:if test="${userId == ''}">
                  userId Null!!!
                  </c:if> --%>
                  
                  	<a href="/s_Board/index" class="btn btn-link signup" data-toggle="modal" id="home">홈으로</a>
                  <c:if test="${userId == 'admin'}">
                  	<a href="/s_Board/admin" class="btn btn-link signup" data-toggle="modal" id="admin">관리</a>
                  </c:if>
                  <c:choose>
                  <c:when test="${userId == null}">
                  	<a href="#signup-modal" class="btn btn-link signup" data-toggle="modal">Sign Up</a>
                	<a href="#login-modal" class="btn btn-link login" id="login" data-toggle="modal">Login</a> 
                	<a href="#pwdSearch-modal" class="btn btn-link signup" data-toggle="modal" id="pwdSearch">비밀번호 찾기</a>
                  </c:when>
                  
                  <c:otherwise>
                	<a onclick="logout()"  class="btn btn-link login" id="login" data-toggle="modal">Logout</a> 
                	<a href="/s_Board/changeInfo" class="btn btn-link login" id="myPage">정보수정</a>
                	<a href="/s_Board/list" class="btn btn-link signup" data-toggle="modal" id="boardList">게시판</a>
                  </c:otherwise>
                  </c:choose>
              </div>
            </div>
          </div>
        </div>
      </div>
      
  </div>
</div>
