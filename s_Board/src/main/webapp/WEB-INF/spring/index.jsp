<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!--Plugin: Retina.js (high def image replacement) - @see: http://retinajs.com/-->
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript">

$(function () {
    $("#myCarousel").carousel({ interval: 1500 });
 
	$("#logBtn").click(function() {
			var serializedData = $("#loginForm").eq(0).serialize();
			$.ajax({
				type : "post",
				url : "../join/login",
				data : serializedData,
				dateType : "json",
				success : function(json) {
					if (json.loginOk) {
						alert("LoginOk");
						location.href = "../main/index";
					} else {
						alert("Please check your ID and password");
					}
				}
			})

		});
	
	
//////////////////////////////////////이메일 인증///////////////////////////////////////	
	 $("#authBtn").click(function() {
		 $('#authBtn').attr('disabled',true);
		 var receiver = $("#receiver1").val()+$("#receiver2").val();
			$("#receiver").val(receiver); 
			 var msg = confirm('이메일 인증하시겠습니까? 최대 1분 소요됩니다.');
			 if(msg){
				 $.ajax({
						type:"post",
						url:"../email/send",
						data: {"receiver":$("#receiver").val()},
						dateType : "json",
						success: function(json){
							if(json.result){
								var msg = confirm("Would you like to go to Google?");
								if(msg){
									console.log("성공!");
								}
							}else{
								alert("Authentication Fail");
								location.href="emailAuthForm";
							}
							
						}
					})
			 }else{
				 location.href="../main/index";
			 }
		});
	 
	 
	 
	 
	 
////////////////////////////////////////패스워드 찾기 -> 아이디,이메일 일치 검사///////////////////////////////////////////////	 
	$("#searchBtn").click(function() {
		 var sId = $("#sId").val();
		
		 var sReceiver = $("#sEmail1").val()+$("#sEmail2").val();
		  $("#sReceiver").val(sReceiver); 
		  var serializedData2 = $("#pwdSearchForm").eq(0).serialize();
		alert('gg');
	  	$.ajax({
			type:"post",
			url:"../pwdSearch/idEmailCheck",
			data: serializedData2,
			dateType : "json",
			success: function(json){
				if(json.idEmailOk){
					alert("이메일 발송중입니다....");
					
					location.href="../pwdSearch/pwdSearch?email="+sReceiver+"&id="+sId;
					
				}else{
					alert("ID와 EMAIL을 다시 한번 확인해주세요.")
				}
				
				
			}
		})
		
	});	 
	 	 
});
</script>
<tiles:insertDefinition name="index">
<title><tiles:putAttribute name="title">U L T R A S T U D Y</tiles:putAttribute></title>

	<tiles:putAttribute name="body">
	<!-- ======== @Region: #highlighted ======== -->
<div id="highlighted">
  <!-- Showshow - Slider Revolution see: plugins/slider-revolution/examples&sources for help invoke using data-toggle="slider-rev" options can be passed to the slider via HTML5 data- ie. data-startwidth="960" -->
  <div class="slider-wrapper tp-banner-container" data-page-class="slider-revolution-full-width-behind slider-appstrap-theme">
    <div class="tp-banner" data-toggle="slider-rev" data-delay="9000" data-startwidth="1100" data-startheight="590" data-fullWidth="off">
      <ul>
        <!-- SLIDE 1 -->
        <li class="slide" data-transition="fade" data-slotamount="5" data-masterspeed="1800">
          <img src=<c:url value="/resources/img/patterns/white_wall_hash.png"/> alt="slidebg1" data-bgfit="normal" data-bgposition="left top" data-bgrepeat="repeat">
          <!-- SLIDE 1 Content-->
          <div class="slide-content">
            <!--elements within .slide-content are pushed below navbar on "behind"-->
            <div class="tp-caption sfb ltl" data-x="10" data-y="50" data-speed="400" data-start="800" data-easing="Back.easeOut" data-endspeed="500" data-endeasing="Back.easeIn" data-captionhidden="on">
              <img src=<c:url value="/resources/img/slides/teacher.png"/> alt="Slide 1" />
            </div>
            <h2 class="tp-caption customin randomrotateout" data-x="700" data-y="120" data-speed="400" data-start="1200" data-customin="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0;scaleY:0;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-easing="Back.easeOut" data-endspeed="400" data-endeasing="Back.easeIn">
              CLASS가 다른 점수 상승! Ultra Study 강의
            </h2>
            <h4 class="tp-caption customin randomrotateout" data-x="700" data-y="160" data-speed="400" data-start="1400" data-customin="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0;scaleY:0;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-easing="Back.easeOut" data-endspeed="400" data-endeasing="Back.easeIn">
              By. <a href="index">Ultra Study</a>
            </h4>
            <p class="tp-caption customin randomrotateout" data-x="700" data-y="190" data-speed="400" data-start="1600" data-customin="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0;scaleY:0;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-easing="Back.easeOut" data-endspeed="400" data-endeasing="Back.easeIn">Perfect for your Score, command of English!</p>
            <a href="#" class="tp-caption customin randomrotateout btn btn-lg btn-primary" data-x="700" data-y="220" data-speed="400" data-start="1800" data-customin="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0;scaleY:0;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-easing="Back.easeOut" data-endspeed="400" data-endeasing="Back.easeIn">수강신청</a> 
          </div>
        </li>
        <!-- SLIDE 2 -->
        <li data-transition="curtain-1" data-slotamount="4" data-masterspeed="500" >
          <img src=<c:url value="/resources/img/patterns/lightpaperfibers.png"/> alt="slidebg1" data-bgfit="normal" data-bgposition="left top" data-bgrepeat="repeat">
          <!-- SLIDE 2 Content -->
          <div class="slide-content">
            <!--elements within .slide-content are pushed below navbar on "behind"-->
            <div class="tp-caption sfb ltr" data-x="left" data-y="bottom" data-speed="900" data-start="1200" data-easing="Elastic.easeOut" data-endspeed="200" data-endeasing="Power0.easeInOut">
              <img src=<c:url value="/resources/img/slides/ad2.PNG"/> alt="Slide 2 layer 1" />
            </div>
            <div class="tp-caption sfb ltr" data-x="center" data-y="bottom" data-speed="900" data-start="1500" data-easing="Elastic.easeOut" data-endspeed="200" data-endeasing="Power0.easeInOut">
              <img src=<c:url value="/resources/img/slides/ad03.PNG"/> alt="Slide 2 layer 3" />
            </div>
            <div class="tp-caption sfb ltr" data-x="right" data-y="bottom" data-speed="700" data-start="1900" data-easing="Elastic.easeOut" data-endspeed="200" data-endeasing="Power0.easeInOut">
              <img src=<c:url value="/resources/img/slides/ad1.PNG"/> alt="Slide 2 layer 2" />
            </div>
            <h2 class="tp-caption largeblackbg sfb randomrotateout" data-x="center" data-y="200" data-speed="1500" data-start="2300" data-easing="Elastic.easeOut" data-endspeed="200" data-endeasing="Power0.easeInOut">
              You can do it! We make together
            </h2>
          </div>
        </li>
      </ul>
      <div class="tp-bannertimer tp-bottom"></div>
    </div>
    <!--end of tp-banner-->
  </div>
</div>

<!-- end of slides-->

<div id="content">
  <div class="container">
    <!-- Services -->
    <div class="block features">
      <h2 class="title-divider">
        <span>Notice & <span class="de-em">Schedule</span></span>
        <small>Ultra Study의 공지사항과 주요 일정들을 확인할 수 있습니다.</small>
      </h2>
      
    </div>
    <br>
    <!--Pricing Table-->
		<div class="block">
			<h2 class="title-divider">
				<span>Ultra <span class="de-em">Teacher</span></span> <small>1등의 영어, Ultra Study만 믿고 따르면 반드시 됩니다.</small>
			</h2>
		 <div id = "myCarousel" class = "carousel slide" style="width:100%; margin-left:50px;">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner" >
			<div class="item active">
				<a href="../info/teacherInfo">
				<table>
				<tr>
				   <td>
					   <img src=<c:url value="/resources/img/team/adele@2x.jpg"/>>
					   <img src=<c:url value="/resources/img/team/bono@2x.jpg"/>>
					   <img src=<c:url value="/resources/img/team/kate@2x.jpg"/>>
					   <img src=<c:url value="/resources/img/team/jimi@2x.jpg"/>>
					   <img src=<c:url value="/resources/img/team/steve@2x.jpg"/>>
				   </td>
				</tr>
				</table>
				</a>
				</div>
			<div class="item">
			<a href="../info/teacherInfo">
				<table>
				<tr>
				   <td>
					 <img src=<c:url value="/resources/img/team/bono@2x.jpg"/>>
					 <img src=<c:url value="/resources/img/team/kate@2x.jpg"/>>
					 <img src=<c:url value="/resources/img/team/jimi@2x.jpg"/>>
					 <img src=<c:url value="/resources/img/team/steve@2x.jpg"/>>
					 <img src=<c:url value="/resources/img/team/jolie@2x.jpg"/>>
				   </td>
				</tr>
				</table>
				</a>
			</div>
			<div class="item">
			<a href="../info/teacherInfo">
				<table >
				<tr>
				   <td>
					<img src=<c:url value="/resources/img/team/kate@2x.jpg"/>>
					<img src=<c:url value="/resources/img/team/jimi@2x.jpg"/>>
					<img src=<c:url value="/resources/img/team/steve@2x.jpg"/>>
				   	<img src=<c:url value="/resources/img/team/jolie@2x.jpg"/>>
				   	<img src=<c:url value="/resources/img/team/robert@2x.jpg"/>>
				   </td>
				</tr>
				</table>
				</a>
			</div>
		</div>

		</div> 

<br>
    <div class="block testimonials margin-top-large">
      <h2 class="title-divider">
        <span>Ultra <span class="de-em">Comments</span></span>
        <small>생생한 수강후기! ULTRA 수강생의 솔직한 후기를 확인하세요. </small>
      </h2>
      <div class="row">
        <div class="col-md-4">
          <blockquote>
            <p>"10 out of 10, highly recommended!"</p>
            <small>
              <img src=<c:url value="/resources/img/team/kate.jpg"></c:url> alt="Jimi Bloggs" class="img-circle" />
              최준아 <span class="spacer">/</span> <a href="#">@juna_v</a>
            </small>
          </blockquote>
        </div>
        <div class="col-md-4">
          <blockquote>
            <p>"원리이해중심의 명품강의! 왜 원리이해 중심강의인지 알겠어요♥"</p>
            <small>
              <img src=<c:url value="/resources/img/team/jolie.jpg"></c:url> alt="Jimi Bloggs" class="img-circle" />
              이은주 <span class="spacer">/</span> <a href="#">@eunjoolove</a>
            </small>
          </blockquote>
        </div>
        <div class="col-md-4">
          <blockquote>
            <p>"선생님 감사해요 정말 많은걸 배웠어요 "</p>
            <small>
              <img src=<c:url value="/resources/img/team/jimi.jpg"></c:url> class="img-circle" />
              한상백 <span class="spacer">/</span> <a href="#">@hansb</a>
            </small>
          </blockquote>
        </div>

        
      </div>
    </div>
  </div>
</div>
</div>
<!-- end of 수강후기-->
	</tiles:putAttribute>
</tiles:insertDefinition>
