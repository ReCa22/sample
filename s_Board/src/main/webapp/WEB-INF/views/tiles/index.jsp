<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!--Plugin: Retina.js (high def image replacement) - @see: http://retinajs.com/-->
<style>
div#resolution {
    width: 50%;
    float: left;
}
div#review {
    width: 50%;
    float: right;
}
</style>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript">
$(init);

function init(){
	kCalendar('kCalendar');
	var test = "시험기간";
	var start = "개강";

	<c:forEach var="cal" items="${cal}">
	var cdate = ${cal.cdate }
	if("${cal.event }"==test){
	$('#'+cdate).css("background-color","lightgray");
	}else if("${cal.event }"==start){
		$('#'+cdate).css("background-color","orange");
	}else{
		$('#'+cdate).css("background-color","green");
		}
	</c:forEach>	
}
function kCalendar(id, date) {
	var kCalendar = document.getElementById(id);
	
	if( typeof( date ) !== 'undefined' ) {
		date = date.split('-');
		date[1] = date[1] - 1;
		date = new Date(date[0], date[1], date[2]);
	} else {
		var date = new Date();
	}
	var currentYear = date.getFullYear();
	//년도를 구함
	
	var currentMonth = date.getMonth() + 1;
	//연을 구함. 월은 0부터 시작하므로 +1, 12월은 11을 출력
	
	var currentDate = date.getDate();
	//오늘 일자.
	
	date.setDate(1);
	var currentDay = date.getDay();
	//이번달 1일의 요일은 출력. 0은 일요일 6은 토요일
	
	var dateString = new Array('sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat');
	var lastDate = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	if( (currentYear % 4 === 0 && currentYear % 100 !== 0) || currentYear % 400 === 0 )
		lastDate[1] = 29;
	//각 달의 마지막 일을 계산, 윤년의 경우 년도가 4의 배수이고 100의 배수가 아닐 때 혹은 400의 배수일 때 2월달이 29일 임.
	
	var currentLastDate = lastDate[currentMonth-1];
	var week = Math.ceil( ( currentDay + currentLastDate ) / 7 );
	//총 몇 주인지 구함.
	
	if(currentMonth != 1)
		var prevDate = currentYear + '-' + ( currentMonth - 1 ) + '-' + currentDate;
	else
		var prevDate = ( currentYear - 1 ) + '-' + 12 + '-' + currentDate;
	//만약 이번달이 1월이라면 1년 전 12월로 출력.
	
	if(currentMonth != 12) 
		var nextDate = currentYear + '-' + ( currentMonth + 1 ) + '-' + currentDate;
	else
		var nextDate = ( currentYear + 1 ) + '-' + 1 + '-' + currentDate;
	//만약 이번달이 12월이라면 1년 후 1월로 출력.

	
	if( currentMonth < 10 )
		var currentMonth = '0' + currentMonth;
	//10월 이하라면 앞에 0을 붙여준다.
	
	var calendar = '';
	
	calendar += '<div id="header">';
	calendar += '			<span><a href="#" class="button left" onclick="kCalendar(\'' +  id + '\', \'' + prevDate + '\')"><</a></span>';
	calendar += '			<span id="date">' + currentYear + '년 ' + currentMonth + '월</span>';
	calendar += '			<span><a href="#" class="button right" onclick="kCalendar(\'' + id + '\', \'' + nextDate + '\')">></a></span>';
	calendar += '		</div>';
	calendar += '		<table border="0" cellspacing="0" cellpadding="0">';
	calendar += '			<caption>' + currentYear + '년 ' + currentMonth + '월 달력</caption>';
	calendar += '			<thead>';
	calendar += '				<tr>';
	calendar += '				  <th class="sun" scope="row">일</th>';
	calendar += '				  <th class="mon" scope="row">월</th>';
	calendar += '				  <th class="tue" scope="row">화</th>';
	calendar += '				  <th class="wed" scope="row">수</th>';
	calendar += '				  <th class="thu" scope="row">목</th>';
	calendar += '				  <th class="fri" scope="row">금</th>';
	calendar += '				  <th class="sat" scope="row">토</th>';
	calendar += '				</tr>';
	calendar += '			</thead>';
	calendar += '			<tbody>';
	
	var dateNum = 1 - currentDay;
	
	for(var i = 0; i < week; i++) {
		calendar += '<tr>';
		for(var j = 0; j < 7; j++, dateNum++) {
			if( dateNum < 1 || dateNum > currentLastDate ) {
				calendar += '<td class="' + dateString[j] + '"> </td>';
				continue;
			}
			calendar += '<td id = "'+currentYear+''+currentMonth+''+dateNum+'" class="' + dateString[j] + '" onclick="choice('+currentYear+''+currentMonth+''+dateNum+')">' + dateNum + '</td>';
			
			
		}
		calendar += '</tr>';
	}
	
	calendar += '			</tbody>';
	calendar += '		</table>';
	
	kCalendar.innerHTML = calendar;
	var test = "시험기간";
	var start = "개강";

	<c:forEach var="cal" items="${cal}">
	var cdate = ${cal.cdate }
	if("${cal.event }"==test){
	$('#'+cdate).css("background-color","lightgray");
	}else if("${cal.event }"==start){
		$('#'+cdate).css("background-color","orange");
	}else{
		$('#'+cdate).css("background-color","green");
		}
	</c:forEach>	
}

$(function () {
	   var userid = $('#userId').val();
	    var b = "true";
	    console.log(userid);
	    if(userid==b){
	    	$("#myModal").modal();
	    }
	    $("#myCarousel").carousel({ interval: 1500 });
	    

		 
		 
		 
	////////////////////////////////////////패스워드 찾기 -> 아이디,이메일 일치 검사///////////////////////////////////////////////	 
		$("#searchBtn").click(function() {
			 var sId = $("#sId").val();
			
			 var sReceiver = $("#sEmail1").val()+$("#sEmail2").val();
			  $("#sReceiver").val(sReceiver); 
			  var serializedData2 = $("#pwdSearchForm").eq(0).serialize();
		  	$.ajax({
				type:"post",
				url:"/WebPro/pwdSearch/idEmailCheck",
				data: serializedData2,
				dateType : "json",
				success: function(json){
					if(json.idEmailOk){
						alert("이메일 발송중입니다/WebPro/WebPro");
						
						location.href="/WebPro/pwdSearch/pwdSearch?email="+sReceiver+"&id="+sId;
						
					}else{
						alert("ID와 EMAIL을 다시 한번 확인해주세요.")
					}
					
					
				}
			})
			
		});	 
	});
function emailAuth() {
    var receiver = $("#receiver1").val()+$("#receiver2").val();
      $("#receiver").val(receiver); 
          $.ajax({
               type:"post",
               url:"../join/emailOverlabCheck",
               data: {"receiver":$("#receiver").val()},
               dateType : "json",
               success: function(json){
               if(json.emailOverlab){
                  $("#emailAuth").modal();
               }else{
                  $("#emailOverlab").modal();   
               }
                  
               }
            })
       
}

function authGo() {
    $('#authBtn').attr('disabled',true);
    var receiver = $("#receiver1").val()+$("#receiver2").val();
      $("#receiver").val(receiver);
    $.ajax({
         type:"post",
         url:"../email/send",
         data: {"receiver":$("#receiver").val()},
         dateType : "json",
         success: function(json){
            if(json.result){
               $("#googleGo").modal();
            }else{
               $("authFail").modal();
               
            }
            
         }
      })
}
</script>
<style>
td {
	font-size: 15px;
	height: 25px;
}
body{
	font-family: sans-serif;
}
table {
	font-family: sans-serif;

}
span.h3 {
    margin-left: 2%;
}


#kCalendar {
   width: 420px;
   height: 250px;
   /* border: 1px solid black; */

}

#kCalendar #header {
   background-color: #55A79A;
   height: 50px;
   line-height: 50px;
   text-align: center;
   font-size: 18px;
   font-weight: bold
}

#kCalendar .button {
   color: #000;
   text-decoration: none;
}

#kCalendar table {
   width: 420px;
   height: 200px;
}

#kCalendar caption {
   display: none;
}

#kCalendar .sun {
   text-align: center;
   color: deeppink;
}

#kCalendar .mon {
   text-align: center;
}

#kCalendar .tue {
   text-align: center;
}

#kCalendar .wed {
   text-align: center;
}

#kCalendar .thu {
   text-align: center;
}

#kCalendar .fri {
   text-align: center;
}

#kCalendar .sat {
   text-align: center;
   color: deepskyblue;
}
.cal{
   margin-left:60%;
}
.notice{
   float:left;
   margin-left:3%;
}
div#kCalendar{
   float:right;
   margin-right:5%;
}
.more{
   margin-left: 67%;
}
.info{
   margin-left: 5%;
}
span#schedule {
    margin-left: 17%;
}

</style>
<tiles:insertDefinition name="index">
<title><tiles:putAttribute name="title">U L T R A S T U D Y</tiles:putAttribute></title>

	<tiles:putAttribute name="body">
	<style>
		.col-md-4 {
	    width: 50%;
		}
	</style>
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
            <a href="/WebPro/order/list" class="tp-caption customin randomrotateout btn btn-lg btn-primary" data-x="700" data-y="220" data-speed="400" data-start="1800" data-customin="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0;scaleY:0;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-easing="Back.easeOut" data-endspeed="400" data-endeasing="Back.easeIn">수강신청</a> 
          </div>
        </li>
        <!-- SLIDE 2 -->
        <li data-transition="curtain-1" data-slotamount="4" data-masterspeed="500" >
          <img src=<c:url value="/resources/img/patterns/lightpaperfibers.png"/> alt="slidebg1" data-bgfit="normal" data-bgposition="left top" data-bgrepeat="repeat">
          <!-- SLIDE 2 Content -->
          <div class="slide-content">
            <!--elements within .slide-content are pushed below navbar on "behind"-->
            <div class="tp-caption sfb ltr" data-x="left" data-y="bottom" data-speed="900" data-start="1200" data-easing="Elastic.easeOut" data-endspeed="200" data-endeasing="Power0.easeInOut">
              <img src=<c:url value="/resources/img/slides/ad02.PNG"/> alt="Slide 2 layer 1" />
            </div>
            <div class="tp-caption sfb ltr" data-x="center" data-y="bottom" data-speed="900" data-start="1500" data-easing="Elastic.easeOut" data-endspeed="200" data-endeasing="Power0.easeInOut">
              <img src=<c:url value="/resources/img/slides/ad03.PNG"/> alt="Slide 2 layer 3" />
            </div>
            <div class="tp-caption sfb ltr" data-x="right" data-y="bottom" data-speed="700" data-start="1900" data-easing="Elastic.easeOut" data-endspeed="200" data-endeasing="Power0.easeInOut">
              <img src=<c:url value="/resources/img/slides/ad001.PNG"/> alt="Slide 2 layer 2" />
            </div>
            <h2 class="tp-caption largeblackbg sfb randomrotateout" data-x="center" data-y="200" data-speed="1500" data-start="2300" data-easing="Elastic.easeOut" data-endspeed="200" data-endeasing="Power0.easeInOut">
              You can do it! We make together
            </h2>
          </div>
        </li>
		<!-- SLIDE 3 -->
        <li class="slide" data-transition="fade" data-slotamount="2" data-masterspeed="1800">
          <img src=<c:url value="/resources/img/patterns/white_wall_hash.png"/> alt="slidebg1" data-bgfit="normal" data-bgposition="left top" data-bgrepeat="repeat">
          <!-- SLIDE 1 Content-->
          <div class="slide-content">
            <!--elements within .slide-content are pushed below navbar on "behind"-->
            <div class="tp-caption sfb ltl" data-x="center" data-y="130" data-speed="400" data-start="800" data-easing="Back.easeOut" data-endspeed="500" data-endeasing="Back.easeIn" data-captionhidden="on">
              <img src=<c:url value="/resources/img/timetable.jpg"/> alt="Slide 1" />
            </div>            
            <div style="font-size:50" class="tp-caption customin randomrotateout" data-x="center" data-y="50" data-speed="400" data-start="1200" data-customin="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0;scaleY:0;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-easing="Back.easeOut" data-endspeed="400" data-endeasing="Back.easeIn">
              Ultra TimeTable.
            </div>
             <div style="font-size:30; background-color: black; color:white" class="tp-caption customin randomrotateout" data-x="center" data-y="20" data-speed="400" data-start="1600" data-customin="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0;scaleY:0;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" data-easing="Back.easeOut" data-endspeed="400" data-endeasing="Back.easeIn">
              &nbsp 수강기간 : 2015. 12. 18 ~ 2016. 1. 17 &nbsp
            </div>
       </div>
        </li>
      </ul>
      <div class="tp-bannertimer tp-bottom"></div>
    </div>

      </ul>
      <div class="tp-bannertimer tp-bottom"></div>
    </div>
    <!-- Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
               <div class="modal-dialog" role="document">
                  <div class="modal-content" style="width:60%" >
                     <div class="modal-header" style="background-color: #55A79A">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">알림창</h4>
                     </div>
                     <div class="modal-body">
                          <div class="block">
                           로그인 후 사용해 주세요.
                     </div>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
                        <!-- <button type="button" class="btn btn-primary" onclick="apply()"></button> -->
                     </div>
                  </div>
               </div>
            </div>
    <!--end of tp-banner-->
  </div>
</div>

<!-- end of slides-->

<div id="content">
  <div class="container">
   <input type="hidden" value="${user}" id="userId">
    <!-- Services -->
    <div class="block features">
      <h2 class="title-divider">
        <span>Notice & <span class="de-em">Schedule</span></span>
        <small>Ultra Study의 공지사항과 주요 일정들을 확인할 수 있습니다.</small>
      </h2>
      	<div class="notice"><span class="h3">Notice.</span><a class="more" href = "/WebPro/qna/list">more</a>
      <table>
					<c:forEach var="board" items="${list}">
						<tr>
							<td style="width:350px"><a href="/WebPro/qna/boardInfo?num=${board.num}&page=1">* ${board.title}(${board.refcnt})</a></td>
							<td>${board.qdate}</td>
						</tr>
					</c:forEach>
				</table>
				</div>
				<h3><span class="de-em" id="schedule" >Schedule.</span>
				              <c:if test="${userId == '관리자'}">
            <span style="margin-left:20%">           
            <a class="btn btn-primary" href="/WebPro/cal/addCalendar">일정수정</a></span>
            </c:if></h3>				
			<div id="kCalendar"></div>
				<h1><span style="margin-left: 10%; color:orange;">■</span></h1><span style="margin-left: 10%; ">개강</span><br>
				<h1><span style="margin-left: 10%;  color:green;">■</span></h1><span style="margin-left: 10%;">종강</span><br>
				<h1><span style="margin-left: 10%;  color:lightgray;">■</span></h1><span style="margin-left: 10%;">시험</span>
				
				
	
    </div>
    <br>
    <!--Pricing Table-->
		<div class="block" style="display:inline-block">
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
				<a href="/WebPro/info/teacherInfo">
				<table>
				<tr>
				   <td>
					   <img src=<c:url value="/resources/img/team/teacher1.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher2.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher3.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher4.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher5.PNG"/> style="width:210px; height:310px;">
				   </td>
				</tr>
				</table>
				</a>
				</div>
			<div class="item">
			<a href="/WebPro/info/teacherInfo">
				<table>
				<tr>
				   <td>
					   <img src=<c:url value="/resources/img/team/teacher2.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher3.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher4.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher5.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher6.PNG"/> style="width:210px; height:310px;">
				   </td>
				</tr>
				</table>
				</a>
			</div>
			<div class="item">
			<a href="/WebPro/info/teacherInfo">
				<table>
				<tr>
				   <td>
					   <img src=<c:url value="/resources/img/team/teacher3.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher4.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher5.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher6.PNG"/> style="width:210px; height:310px;">
					   <img src=<c:url value="/resources/img/team/teacher7.PNG"/> style="width:210px; height:310px;">
				   </td>
				</tr>
				</table>
				</a>
			</div>
		</div>

		</div> 

<br>
  </div>
    <div class="block testimonials margin-top-large">
      <h2 class="title-divider">
        <span>Ultra <span class="de-em">Comments</span></span>
        <small>생생한 수강후기! ULTRA 수강생의 솔직한 후기를 확인하세요. </small>
      </h2>
      <div class="row" id="resolution">
        <div class="col-md-4">
          <blockquote>
            <p>${info[0].myresolve} </p>
            <small>
              <img src=<c:url value="/resources/img/team/kate.jpg"></c:url> alt="Jimi Bloggs" class="img-circle" />
              ${info[0].name} <span class="spacer">/</span> <a href="#">${info[0].id}</a>
            </small>
          </blockquote>
        </div>

        <div class="col-md-4">
          <blockquote>
            <p>${info[1].myresolve}</p>
            <small>
              <img src=<c:url value="/resources/img/team/jolie.jpg"></c:url> alt="Jimi Bloggs" class="img-circle" />
              ${info[1].name} <span class="spacer">/</span> <a href="#">${info[1].id}</a>
            </small>
          </blockquote>
        </div>

        <div class="col-md-4">
          <blockquote>
            <p>${info[2].myresolve}</p>
            <small>
              <img src=<c:url value="/resources/img/team/jimi.jpg"></c:url> class="img-circle" />
              ${info[2].name} <span class="spacer">/</span> <a href="#">${info[2].id}</a>
            </small>
          </blockquote>
        </div>
      </div>
      <div class="row" id="review">
      
      </div>
    </div>
    
</div>
</div>


<!-- end of 수강후기-->
<!-- Modal2 -->
            <div class="modal fade" id="emailSending" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
               <div class="modal-dialog" role="document">
                  <div class="modal-content">
                     <div class="modal-header" style="background-color: #55A79A">
                        <h5 class="modal-title" id="myModalLabel">비밀번호 전송 여부</h5>
                     </div>
                     <div class="modal-body">
                          <div class="block">
                        <h4>
                           <span>비밀번호 전송 완료</span>
                        </h4>
                     </div>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal"> 확 인 </button>
                     </div>
                  </div>
               </div>
            </div>
            
       <!-- Modal3 -->
            <div class="modal fade" id="idemailCheck" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
               <div class="modal-dialog" role="document">
                  <div class="modal-content">
                     <div class="modal-header" style="background-color: #55A79A">
                        <h5 class="modal-title" id="myModalLabel">ID,EMAIL 확인여부</h5>
                     </div>
                     <div class="modal-body">
                          <div class="block">
                        <h4>
                           <span>아이디와 이메일을 확인해주세요.</span>
                        </h4>
                     </div>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal"> 확 인 </button>
                     </div>
                  </div>
               </div>
            </div>      
<!------------------------ 이메일인증 Modal--------------------------------------------->
 <!-- emailAuthModal1 -->
            <div class="modal fade" id="emailAuth" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
               <div class="modal-dialog" role="document">
                  <div class="modal-content">
                     <div class="modal-header" style="background-color: #55A79A">
                        <h5 class="modal-title" id="myModalLabel">E-MAIL 인증확인여부</h5>
                     </div>
                     <div class="modal-body">
                          <div class="block">
                        <h4>
                           <span>이메일을 인증하시겠습니까? 최대 1분 소요됩니다.</span>
                        </h4>
                     </div>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="authGo()"> 인 증 </button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal"> 취 소 </button>
                        
                     </div>
                  </div>
               </div>
            </div>   
<!-- emailAuthModal2 -->
            <div class="modal fade" id="googleGo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
               <div class="modal-dialog" role="document">
                  <div class="modal-content">
                     <div class="modal-header" style="background-color: #55A79A">
                        <h5 class="modal-title" id="myModalLabel">E-MAIL 인증확인여부</h5>
                     </div>
                     <div class="modal-body">
                          <div class="block">
                        <h4>
                           <span>구글페이지로 이동하시겠습니까?</span>
                        </h4>
                     </div>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='http://www.google.com'"> 이 동 </button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal"> 취 소 </button>
                        
                     </div>
                  </div>
               </div>
            </div>

<!-- emailAuthModal2 -->
            <div class="modal fade" id="authFail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
               <div class="modal-dialog" role="document">
                  <div class="modal-content">
                     <div class="modal-header" style="background-color: #55A79A">
                        <h5 class="modal-title" id="myModalLabel">E-MAIL 인증확인여부</h5>
                     </div>
                     <div class="modal-body">
                          <div class="block">
                        <h4>
                           <span>인증 실패</span>
                        </h4>
                     </div>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='emailAuthForm'"> 확 인 </button>
                     </div>
                  </div>
               </div>
            </div>
<!-- emailAuthModal3 -->
<div class="modal fade" id="emailOverlab" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header" style="background-color: #55A79A">
            <h5 class="modal-title" id="myModalLabel">E-MAIL 사용여부</h5>
         </div>
         <div class="modal-body">
              <div class="block">
            <h4>
               <span>이미 사용중인 E-MAIL입니다.</span>
            </h4>
         </div>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal"> 확 인 </button>
         </div>
      </div>
   </div>
</div>   
	</tiles:putAttribute>
</tiles:insertDefinition>
