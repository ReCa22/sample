<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<tiles:insertDefinition name="tiles.definition">
	<tiles:putAttribute name="body">
		<script type="text/javascript">
		$(document).ready(function() {
			var idCheck = true;
			var pwCheck = true;
			var postCheck = true;
			var regId = true;
			
			
			$("#id").keydown(function() {
				idCheck = true;
				var idLength = $("#id").val().length+1;
				if(idLength < 6){
					$("#id").attr("style", "background-color : pink")
				}else{
					$("#id").attr("style", "background-color : white")
				}
				
			});
			$("#idDoubleSearch").click(function() {
				var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
				if(idReg.test($("#id").val())){
					// console.log("ID OK");
					regId = false;
				}
				var idLength = $("#id").val().length+1;
				if(idLength < 7){
					$("#modalTitle").text("아이디 길이검사");
					$("#modalContent").text("아이디 6자 미만입니다.");
					
					$("#modal").modal();
				}else if(regId){
					$("#modalTitle").text("아이디 형식검사");
					$("#modalContent").text("아이디 형식이 올바르지 않습니다.");
					
					$("#modal").modal();
				}else{
					$.ajax({
						type : "post",
						url : "/s_Board/joinIdCheck",
						data : {
							"id" : $("#id").val(),
						},
						dateType : "json",
						success : function(json) {
							console.log(json.check);
							if(json.check){
								idCheck = true;
								$("#modalTitle").text("이미 존재하는 아이디");
								$("#modalContent").text("이미 존재하는 아이디 입니다.");
								
								$("#modal").modal();
							}else{
								console.log(idCheck);
								$("#modalTitle").text("사용 가능한 아이디");
								$("#modalContent").text("사용 가능한 아이디입니다.");
//$(".modal-footer").append("<button type='button' id='idCheck' class='btn btn-primary'>사용</button>")								
								$("#id").attr("readonly", "readonly");
								$("#modal").modal();
								
								idCheck = false;
							}
						},
						error : function(err){
							console.log("err");
							console.log(err);
						}
					});
					
				}
			});
			$("#pw").keydown(function() {
				pwCheck = true;
				var pwLength = $("#pw").val().length+1;
				if(pwLength < 7){
					$("#pw").attr("style", "background-color : pink")
				}else{
					$("#pw").attr("style", "background-color : white")
				}
			});
			$("#rpw").keyup(function() {
				var pw = $("#pw").val();
				var rpw = $("#rpw").val();
				if(pw == rpw){
					$("#rpw").css({"background-color" : "white"});
					pwCheck = false;
				}else{
					$("#rpw").css({"background-color" : "pink"});
					pwCheck = true;
				}
			});
			$("#addressBtn").click(function() {
		        new daum.Postcode({
				oncomplete : function(data) {
					console.log(data);	
		        	   
					if(data.address != ''){
						postCheck = false;
					}
		            $('#postcode1').val(data.postcode1);
		            $('#postcode2').val(data.postcode2);
		            $('#address').val(data.address);
		            $('#address_etc').focus();
		           }
		        }).open()
		
		     });
			
			$("#joinBtn").click(function() {
				var pwLength = $("#pw").val().length;
				if(idCheck){
					$("#modalTitle").text("아이디 중복확인검사");
					$("#modalContent").text("아이디 중복확인 버튼을 눌러주세요.");
					$("#modal").modal();
					$("#check").focus();
					$("#check").click(function() {
						document.querySelector("#idDoubleSearch").focus();
						/* $("#idDoubleSearch").focus(); */
					});
				}else if(pwLength < 7){
					$("#modalTitle").text("비밀번호 길이확인");
					$("#modalContent").text("비밀번호가 7자리 이상이여야 합니다");
					$("#modal").modal();
				}else if(pwCheck){
					$("#modalTitle").text("비밀번호 확인");
					$("#modalContent").text("비밀번호가 위와 일치하지 않습니다");
					$("#modal").modal();
				}else if($("#name").val() == ''){
					$("#modalTitle").text("이름 입력확인");
					$("#modalContent").text("이름을 입력해주세요");
					$("#modal").modal();
				}else if(postCheck){
					$("#modalTitle").text("주소 입력확인");
					$("#modalContent").text("주소찾기를 눌러 주세요");
					$("#modal").modal();
				}else if($("input[name=answer]").val() == ''){
					$("#modalTitle").text("답변 입력확인");
					$("#modalContent").text("답변을 입력해주세요");
					$("#modal").modal();
				}else{
					alert("회원가입이 완료되었습니다.");
					$("#joinInfo").submit();
				}
				
			});
		});
		</script>
		<%-- ${receiver1}<br />
		${receiver2}<br />
		${content}<br /> --%>
		<div id="content">
        <div class="container">
    <!-- Sign Up form -->
    
    <form class="form-login form-wrapper form-medium" role="form" id="joinInfo" method="post" action="/s_Board/joinSuccess">
      <h3 class="title-divider">
        <span>Sign Up</span> 
        <small>Already signed up? <a href="login.htm">Login here</a>.</small>
      </h3>
      
      <h5>
        Account Information
      </h5>
       
      <table> 
      
        <tr>
        <td> ID </td> <td> <input type="text" class="form-control" id="id" name="id" placeholder="6자 이상, 10자 이하" maxlength="10"> </td>
        <td> <button class="btn btn-primary" type="button" id="idDoubleSearch" name="idDoubleSearch">중복검사</button> </td>
        </tr>
     
        <tr>
        <td>PW</td> <td> <input type="password" class="form-control" id="pw" name="pw" placeholder="7자 이상, 20자 이하" maxlength="20"> </td>
       </tr>
       
       <tr>
        <td> PWCHECK</td> <td> <input type="password" class="form-control" id="rpw" name="rpw" placeholder="위와 동일하게 작성해주세요"> </td>
        </tr>
        
        <tr>
           <td>이름 </td> <td> <input type="text" class="form-control" id="name" name="name" maxlength="10"> </td>
       </tr>
    
       <tr>
           <td>성별 </td> 
           <td>남<input type="radio" id="gender" name="gender" value="1" checked="checked">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              여<input type="radio" id="gender" name="gender" value="2">
               <input type="hidden" id="genderVal" name="genderVal">
           </td>
         </tr>
   
         <!-- <tr>
           <td>생년월일</td> <td><input type=date class="form-control" id="birth" name="birth"></td>
         </tr>  -->  
         
         <tr>
           <td>이메일</td> <td><input type="text" class="form-control" id="email" name="email" value="${receiver1}@${receiver2}" readonly></td>
           <td>
         </tr>
   
         <tr>
         <td>주소</td>
         <td> <input id="postcode1" name="postcode1" class="form-control" type="text" value="" style="width: 50px;" readonly />
         
         <input type="text" class="form-control" id="postcode2" name="postcode2" value="" style="width: 50px;" readonly />
         
             <button class="btn btn-primary" type="button" id="addressBtn">주소찾기</button> <br> 
            
          <input type="text" class="form-control" id="address" name="address" value=""  readonly />
          
          <input type="text" class="form-control" id="address_etc" name="address_etc" value=""  placeholder="나머지 주소 입력" maxlength="30">
          
          <input type="hidden" id="addressValue" name="addressValue">
          </td>
          <td></td>
      	</tr>
		<tr>
			<td>비밀번호<br />분실 암호</td>
			<!-- <td><input type="text" class="form-control"></td> -->
			<td>
				<select name="question" class="form-control">
					<option value="1" selected="selected">가장 기억에 남는 장소는?</option>
					<option value="2">어머니의 성함은?</option>
				</select>
				<br />
				<input type="text" class="form-control" name="answer">
			</td>
			<td></td>
		</tr>
        <tr>
            
        <td><button class="btn btn-primary" type="button" id="joinBtn" name="joinBtn">완 료</button><td>
         </tr>
      </table>
         
    </form>
    <br /><br /><br /><br /><br /><br /><br /><br /><br />
    <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
               <div class="modal-dialog" role="document">
                  <div class="modal-content">
                     <div class="modal-header" style="background-color: #55A79A">
                        <h5 class="modal-title" id="modalTitle">이메일 중복검사</h5>
                     </div>
                     <div class="modal-body">
                          <div class="block">
                        <h4>
                           <span id="modalContent">이메일 중복검사를 해주세요.</span>
                        </h4>
                     </div>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="check"> 확 인 </button>
                     </div>
                  </div>
               </div>
            </div>
  </div>
      </div>
      
	</tiles:putAttribute>
</tiles:insertDefinition>
