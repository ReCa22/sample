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
	#replyTable 
	{
		width : 100%;
	}
	th 
	{
    	font-size: 22px;
	}
	td 
	{
		font-size: 20px;
    	height: 44px;
	}
	th a:HOVER
	{
		text-decoration: none;
	}
	#replyBtn
	{
		float: right;
	}
	tr
	{
		border-bottom: 1px silver solid;
	}
	#replyTableDiv 
	{
	    margin-left: 6%;
	    margin-right: 6%;
	}
	.contents
	{
		height: 220px;
	}
	</style>
	<script>
		$(document).ready(function() {
			if('${userId}' == ''){
				alert("로그인이 필요한 서비스입니다.");
				location.href = "/s_Board/index";
			}else{
				console.log('else');
			}
			
			$('#replyTable tr:last-child').attr('class', 'header');
			$('#replyBtn').click(function() {
				var serialize = $("#replyForm").serialize();
				$.ajax({
					url : "/s_Board/writeReply",
					data : serialize,
					dataType : "json",
					success : function(json){
						console.log(json);
						if(json.isCheck){
							location.href = "/s_Board/list";
						}
					},
					error : function(err){
						console.log("err : " + err);
					}
				});
			});
			$("#returnBtn").click(function() {
				location.href = "/s_Board/view?num="+${vo.num};
			})
		});
	</script>
		<div id="content">
			<div class="container">
				<h2 class="title-divider">
					<span>게시판<span class="de-em">답글</span></span>
				</h2>
				<div>
					<div id="replyTableDiv">
						<form id="replyForm">
						<input type="hidden" value="${userId}" name="id">
						<input type="hidden" value="${vo.num}" name="num">
						<input type="hidden" value="${vo.parent}" name="parent">
						<input type="hidden" value="${vo.indent}" name="indent">
						<table id="replyTable">
						<tr class="header"><td>&nbsp;</td><td>&nbsp;</td></tr>
			        	<tr><th><a>제목</a><td><input name="title" type="text" style="width: 612px;" maxlength="33"></td></tr>
			        	<tr class="header"><th><a>내용</a><td class="contents"><textarea name="contents" style="margin: 0px; width: 612px; height: 200px; resize: none;" maxlength="133"></textarea></td></tr>
			        </table>
			        
					<br />
					<button id="returnBtn" type="button" class="btn btn-default btn-lg">돌아가기</button>
					<button id="replyBtn" type="button" class="btn btn-primary btn-lg">완료</button>
					</form>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>