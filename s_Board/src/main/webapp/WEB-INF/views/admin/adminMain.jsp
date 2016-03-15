<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<tiles:insertDefinition name="tiles.definition">
   <tiles:putAttribute name="body">
   <style>
	*
	{
		font-family: sans-serif;
	}
	#reviewTable 
	{
		width : 100%;
	}
	th 
	{
    	height: 44px;
	}
	td 
	{
    	height: 44px;
	}
	th a:HOVER
	{
		text-decoration: none;
	}
	tr
	{
		border-bottom: 1px silver solid;
	}
	.pagenavi {
	    text-align: center;
	    font-size: 22px;
	}
	</style>
	<script>
		$(document).ready(function() {
			
			$("#${page}").css("color", "red");
			$("#${page}").removeAttr("href");
			
			
			if('${userId}' == null || '${userId}' == '' || '${userId}' != 'admin'){
				alert('로그인 후 이용할 수 있습니다.');
				location.href = '/s_Board/index';
			}
			$('#reviewTable tr:last-child').attr('class', 'header');
			if("${list}" == null || "${list}" == ""){
				$('#nullDiv').text('입력된 데이터가 없습니다.');
				$('#nullDiv').attr('style','font-size: 22px; text-align: center; margin-top: 30px; margin-bottom: 30px; color: #55a79a;');
			}
		});
		
	</script>
<!-- ======== @Region: #content ======== -->
<div id="content">
   <div class="container" id="about">
    <div class="row">
      <!-- sidebar -->
      <div class="col-md-3 sidebar">
        
        <!-- Sections Menu-->
        <div class="section-menu">
          <ul class="nav nav-list">
            <li class="nav-header">In This Section</li>
            <li class="active">
              <a href="/s_Board/admin" class="first">
               	게시판관리
                <small>게시판을 관리합니다.</small>
              </a>
            </li>
            <li>
              <a href="/s_Board/userInfo" class="first">
               	회원관리
                <small>회원를 관리합니다.</small>
              </a>
            </li>
            <!-- <li>
              <a href="/s_Board/graph" class="first">
				통계관리
                <small>통계를 관리합니다.</small>
              </a>
            </li> -->
          </ul>
        </div>
      </div>
      <!--main content-->
      <div class="col-md-9">
        <h2 class="title-divider">
          <span>홈페이지 <span class="de-em">관리자</span></span>
          <small>게시판 관리 페이지</small>
        </h2>
        <div>
		        <table id="reviewTable">
					<colgroup>
						<col style="width:15%;">
						<col style="width:15%;">
						<col style="width:auto;">
						<col style="width:15%;">
						<col style="width:15%;">
					</colgroup>
		        	<tr class="header"><th><a>번호</a></th><th><a>아이디</a></th><th><a>제목</a></th><th><a>작성일</a></th><th><a>조회수</a></th></tr>
		        	<c:forEach var="re" items="${list}">
		        	<tr><td>${re.rnum}</td><td>${re.id}</td><td><a href="/s_Board/view?num=${re.num}">${re.title}</a></td><td>${re.day}</td><td>${re.hit}</td></tr>
		        	</c:forEach>
		        </table>
		        <div id="nullDiv"></div>
				<div class="pagenavi">
					<c:set var="nvo" value="${nvo}" scope="request"  />
					<c:set var="nums" value="${nvo.links}" />
					<c:set var="leftMore" value="${nvo.leftMore}" />
					<c:if test="${nvo.leftMore}">
	                  <a href="/s_Board/admin?page=${nums[0]-1}&searchBar=${search}&searchTitle=${searchTitle}">&lt;&lt;</a>
					</c:if>
					<c:forEach var="n" items="${nvo.links}"  varStatus="status">
	                  <c:set var="num" value="${n}" />
	                     [<a id="${num}" href="/s_Board/admin?page=${num}&searchBar=${search}&searchTitle=${searchTitle}">${num}</a>]
	                  </c:forEach>
	               <c:if test="${nvo.rigetMore}">
	                  <a href="/s_Board/admin?page=${nums [fn:length(nums)-1]+1}&searchBar=${search}&searchTitle=${searchTitle}">&gt;&gt;</a>
	               </c:if>
				</div>
		        <br />
		        <div id="searchDiv" style="margin-left: 22%;">
			        <form id="searchForm" method="post" action="/s_Board/admin">				
						<select name="searchTitle" id="searchTitle" style="height: 3%">
							<option value="1">제목</option>
							<option value="2">아이디</option>
						</select>
						<input type="text" name="searchBar" id="searchBar" value="${search}" style="height: 3%; width: 50%">
						<button type="submit" id="searchBtn" style="height: 3%">검색</button>
					</form>
		        	<!-- <select name="searchTitle" id="searchTitle" style="height: 3%">
		        		<option value="1">제목</option>
		        		<option value="2">작성자</option>
		        	</select>
		        	<input type="text" name="searchBar" id="searchBar" style="height: 3%; width: 50%">
		        	<button type="button" class="btn btn-primary" name="searchBtn" id="searchBtn" style="height: 3%">검색</button> -->
		        </div>
		        <!-- totalModal -->
		        <div class="modal fade" id="totalModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								<h5 class="modal-title" id="modalLabel"></h5>
							</div>
							<div class="modal-body">
				        		<div class="block">
								<h4>
									<span id="modalContents"></span>
								</h4>
							</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">돌아가기</button>
							</div>
						</div>
					</div>
				</div>
		        </div>
      </div>
    </div>
    <!--Modal1  -->
    			<div class="modal fade" id="deleteCheck" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								<h5 class="modal-title" id="myModalLabel">에러</h5>
							</div>
							<div class="modal-body">
				        		<div class="block">
								<h4>
									<span>이 선생님은 강의중이기 때문에 삭제할 수 없습니다.</span>
								</h4>
							</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
							</div>
						</div>
					</div>
				</div>
		  	</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>