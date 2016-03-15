<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<tiles:insertDefinition name="index">
	<tiles:putAttribute name="body">
	<style>
	*
	{
		font-family: sans-serif;
	}
	#editTable 
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
	#editeBtn
	{
		float: right;
	}
	#delBtn
	{
		float: right;
	}
	tr
	{
		border-bottom: 1px silver solid;
	}
	#editTableDiv 
	{
	    margin-left: 6%;
	    margin-right: 6%;
	}
	.contents
	{
		height: 140px;
	}
	textarea
	{
		border-color: white;
	}
	</style>
	<script>
		$(document).ready(function() {
			$('#editTable tr:last-child').attr('class', 'header');
			$('#editeBtn').click(function() {
				location.href = "/s_Board/edit?num="+${vo.num};
			});
			$('#delBtn').click(function() {
				console.log('${userId}');
				if(confirm('정말 삭제하시겠습니까? \n답글이 있을 시 함께 삭제 됩니다.') == true){
					
					$.ajax({
			            type : "post",
			            url : "/s_Board/boardDell",
			            dataType : "json",
			            data :  { num: "${vo.num}" },
			            success : function(jsonObj) {
			            	console.log(jsonObj);
			            	alert('삭제되었습니다');
			            	if('${userId}' == 'admin'){
			            		location.href="/s_Board/admin";
			            		return;
			            	}
			            	location.href="/s_Board/list";
			            	
			            	
			            },
			            error : function(err) {
			            	console.log(error);
			            }
			         });
					// location.href = "/WebPro/class/courseDell?cnum=${info.classNum}&num=${info.num}";
				}else{
					return;
				}
			});
			$("#replyBtn").click(function() {
				location.href = "/s_Board/reply?num="+${vo.num};
			});
		});
	</script>
		<div id="content">
			<div class="container">
				<h2 class="title-divider">
					<span>게시판<span class="de-em">수정</span></span>
			        <!-- <small>Ultra Study Writing Introduce!!</small> -->
				</h2>
				<div>
					<div id="editTableDiv">
						<table id="editTable">
						<colgroup>
							<col style="width:15%;">
							<col style="width:35%;">
							<col style="width:15%;">
							<col style="width:35%;">
						</colgroup>
				        	<tr class="header"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
				        	<tr><th><a>제목</a><td>${vo.title}</td><th><a>작성일</a><td>${vo.day}</td></tr>
				        	<tr><th><a>아이디</a><td>${vo.id}</td><th><a>조회수</a><td>${vo.hit}</td></tr>
				        	<tr><th><a>내용</a><td class="contents" colspan="3"><textarea name="contents" style="margin: 10px; width: 612px; height: 125px; resize: none;" maxlength="133" readonly="readonly">${vo.contents}</textarea></td></tr>
				        	<%-- <tr><th><a>첨부파일</a><td colspan="3"><a href="/s_Board/download?file=${vo.changename}">${vo.originname}</a></td></tr> --%>
				        	<tr><th><a>첨부파일</a><td colspan="3"><a href="/s_Board/download?originName=${vo.originname}&changeName=${vo.changename}">${vo.originname}</a></td></tr>
				        </table>
					<br />
					<c:choose>
					<c:when test="${userId=='admin'}">
						<button onclick="location.href='/s_Board/admin'" type="button" class="btn btn-default btn-lg">돌아가기</button>
					</c:when>
					<c:otherwise>
						<button onclick="location.href='/s_Board/list'" type="button" class="btn btn-default btn-lg">돌아가기</button>
					</c:otherwise>
					</c:choose>
					<button id="replyBtn" type="button" class="btn btn-primary btn-lg">답글</button>
					<c:if test="${vo.id eq userId || userId eq 'admin'}">
						<button id="editeBtn" type="button" class="btn btn-default btn-lg">수정</button>
						<button id="delBtn" type="button" class="btn btn-primary btn-lg">삭제</button>
					</c:if>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>