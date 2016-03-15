<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<tiles:insertDefinition name="tiles.definition">
	<tiles:putAttribute name="body">
	<script>
	$(document).ready(function() {
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
		$("#updateBtn").click(function() {
			if($("#pw").val() == ""){
				alert("비밀번호를 입력해주세요");
				return;
			}else if(pwCheck){
				alert("비밀번호를 확인해주세요.");
				return;
			}else if($("#pw").val().length < 7){
				alert("7자리 이상 입력해주세요");
				return;
			}
			var serialize = $("#updateInfo").serialize();
			$.ajax({
				type : "post",
				url : "/s_Board/updateInfo",
				data : serialize,
				dateType : "json",
				success : function(json) {
					console.log(json);
					if(json.memberCheck && json.zipCheck){
						alert("성공적으로 수정되었습니다");
					}else{
						alert("다시 입력해주세요");
//						location.href = "/s_Board/changeInfo";
					}
				},
				error : function(err) {
					console.log("err");
					console.log(err);
				}
			})
		});
	});
	</script>
	<div id="content">
        <div class="container">
    <!-- Sign Up form -->
    
    <form class="form-login form-wrapper form-medium" role="form" id="updateInfo">
      <h3 class="title-divider">
        <span>Change Information</span> 
      </h3>
      
      <h5>
        Account Information
      </h5>
       
      <table> 
      
        <tr>
        <td> ID </td> <td> <input type="text" class="form-control" id="id" name="id" placeholder="6자 이상, 10자 이하" maxlength="10" value="${vo.id}" readonly> </td>
        <td></td>
        </tr>
     
        <tr>
        <td>PW</td> <td> <input type="password" class="form-control" id="pw" name="pw" placeholder="7자 이상, 20자 이하" maxlength="20"> </td>
       </tr>
       
       <tr>
        <td> PWCHECK</td> <td> <input type="password" class="form-control" id="rpw" name="rpw" placeholder="위와 동일하게 작성해주세요"> </td>
        </tr>
        
        <tr>
           <td>이름 </td> <td> <input type="text" class="form-control" id="name" name="name" maxlength="10" value="${vo.name}" readonly> </td>
       </tr>
    
         <tr>
           <td>이메일</td> <td><input type="text" class="form-control" id="email" name="email" value="${vo.email}" readonly></td>
           <td>
         </tr>
   
         <tr>
         <td>주소</td>
         <td> <input id="postcode1" name="postcode1" class="form-control" type="text" value="${vo.postcode1}" style="width: 50px;" readonly />
         
         <input type="text" class="form-control" id="postcode2" name="postcode2" value="${vo.postcode2}" style="width: 50px;" readonly />
         
             <button class="btn btn-primary" type="button" id="addressBtn">주소찾기</button> <br> 
            
          <input type="text" class="form-control" id="address" name="address" value="${vo.address}"  readonly />
          
          <input type="text" class="form-control" id="address_etc" name="address_etc" value="${vo.address_etc}"  placeholder="나머지 주소 입력" maxlength="30">
          
          </td>
          <td></td>
      	</tr>
        <tr>
            
        <td><button class="btn btn-primary" type="button" id="updateBtn">완 료</button><td>
         </tr>
      </table>
         
    </form>
  		</div>
      </div>
	</tiles:putAttribute>
</tiles:insertDefinition>