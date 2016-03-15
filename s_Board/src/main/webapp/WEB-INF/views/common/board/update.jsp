<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<tiles:insertDefinition name="index">
	<tiles:putAttribute name="body">
	<script>
		$(document).ready(function() {
			location.href = "/s_Board/view?num="+${num}
		})
	</script>
	</tiles:putAttribute>
</tiles:insertDefinition>