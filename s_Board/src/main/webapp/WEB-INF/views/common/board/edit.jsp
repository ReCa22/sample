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
	#updateTable 
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
	#editeBtn
	{
		float: right;
	}
	#delBtn
	{
		float: right;
	}
	#x
	{
		float: right;
		color: red;
	}
	tr
	{
		border-bottom: 1px silver solid;
	}
	#updateTableDiv 
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
			if('${userId}' != '${vo.id}' && '${userId}' != 'admin'){
				alert("잘못된 경로입니다.");
				location.href = "/s_Board/index";
			}
			$("#x").click(function() {
				if(confirm('정말 삭제하시겠습니까?') == true){
					console.log("true");
					$.ajax({
						type : "post",
						url : "/s_Board/fileDell",
						data : {num : "${vo.num}"},
						dataType : "json",
						success : function(json){
							if(json.isCheck){
								alert("파일을 삭제했습니다");
								$("#fileCheck").empty();
								$("#fileCheck").append('<input type="file" name="file">');
//								location.href = "/s_Board/edit?num="+${vo.num};
								
							}
						},
						error : function(err){
							console.log("err");
							console.log(err);
						}
					});
				}else{
					return;
				}
			});
			
			
			
			
			$('#updateTable tr:last-child').attr('class', 'header');
			$('#editeBtn').click(function() {
				$("#editeBtn").attr("type","submit");
				$("#editeForm").ajaxForm(options);
			});
			$("#returnBtn").click(function() {
				location.href = "/s_Board/view?num="+${vo.num};
			})
		});
	</script>
		<div id="content">
			<div class="container">
				<h2 class="title-divider">
					<span>게시판<span class="de-em">수정</span></span>
			        <!-- <small>Ultra Study Writing Introduce!!</small> -->
				</h2>
				<div>
					<div id="updateTableDiv">
						<form id="editeForm" method="post" action="/s_Board/boardUpdate" enctype="multipart/form-data">
						<input type="hidden" value="${vo.num}" name="num">
						<table id="updateTable">
						<tr class="header"><td>&nbsp;</td><td>&nbsp;</td></tr>
			        	<tr><th><a>제목</a><td><input name="title" type="text" style="width: 612px;" maxlength="33" value="${vo.title}"></td></tr>
			        	<tr><th><a>내용</a><td class="contents"><textarea name="contents" style="margin: 0px; width: 612px; height: 200px; resize: none;" maxlength="133">${vo.contents}</textarea></td></tr>
			        	<c:choose>
				        	<c:when test="${vo.originname == null}">
				        		<tr><th><a>첨부파일</a><td id="fileCheck" class="file"><input type="file" name="file"></td></tr>
				        	</c:when>
				        	<c:otherwise>
				        		<tr><th><a>첨부파일</a><td  id="fileCheck" class="file">${vo.originname}<a id="x">x</a></td></tr>
				        	</c:otherwise>
			        	</c:choose>
			        	<!-- <tr><th><a>첨부파일</a><td class="file"><input type="file" name="file"></td></tr> -->
			        </table>
			        
					<br />
					<button id="returnBtn" type="button" class="btn btn-default btn-lg">돌아가기</button>
					<button id="editeBtn" type="button" class="btn btn-primary btn-lg">완료</button>
					</form>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>