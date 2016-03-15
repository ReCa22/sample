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
	#writeTable 
	{
		width : 100%;
	}
	th 
	{
    	font-size: 22px;
    	height: 44px;
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
	#insertBtn
	{
		float: right;
	}
	tr
	{
		border-bottom: 1px silver solid;
	}
	#writeTableDiv 
	{
	    margin-left: 6%;
	    margin-right: 6%;
	}
	.contents
	{
		height: 218px;
	}
	</style>
	<script>
		$(document).ready(function() {
			if('${userId}' == null || '${userId}' == ''){
				alert('로그인 후 이용할 수 있습니다.');
				location.href = '/s_Board/index';
			}
			$('#writeTable tr:last-child').attr('class', 'header');
			
			$("#insertBtn").click(function() {
				if($("input[name=title]").val() == ""){
					alert("제목을 입력해주세요");
					return;
				}else if($("textarea[name=contents]").val() == ""){
					alert("내용을 입력해주세요");
					return;
				}
				
				$("#insertBtn").attr("type","submit");
				$("#writeForm").ajaxForm(options);
				location.href = "/s_Board/index";
			});
			/* $('#insertBtn').click(function() {
				var serialize = $("#writeForm").serialize();
				$.ajax({
					type : "post",
					data : serialize,
					dateType : "json",
					url : "/s_Board/write",
					success : function(json){
						console.log(json);
					},
					error : function(err){
						console.log('err');
						console.log(err);
					}
				});
				
			}); */
		});
	</script>
		<div id="content">
			<div class="container">
				<h2 class="title-divider">
					<span>게시판<span class="de-em">글쓰기</span></span>
				</h2>
				<div id="writeTableDiv">
<!-- 					<form id="writeForm" method="post" action="/s_Board/write"> -->
					<form id="writeForm" method="post" action="/s_Board/writeInput" enctype="multipart/form-data">
					<input type="hidden" value="${userId}" name="id">
					<table id="writeTable">
						<tr class="header"><td>&nbsp;</td><td>&nbsp;</td></tr>
			        	<tr><th><a>제목</a><td><input name="title" type="text" style="width: 612px;" maxlength="33" onkeypress="this.value=this.value.replace(/^\s/g,'')"></td></tr>
			        	<tr><th><a>내용</a><td class="contents"><textarea name="contents" style="margin: 0px; width: 612px; height: 200px; resize: none;" maxlength="133" onkeypress="this.value=this.value.replace(/^\s/g,'')"></textarea></td></tr>
			        	<tr><th><a>첨부파일</a><td class="file"><input type="file" name="file"></td></tr>
			        </table>
					<br />
					<input id="insertBtn" type="button" class="btn btn-primary btn-lg" value="등록">
			        </form>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>