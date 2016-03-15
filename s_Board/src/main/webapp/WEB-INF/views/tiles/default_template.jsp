<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<html lang="en">
<head>
<tiles:insertAttribute name="head" />
<title><tiles:insertAttribute name="title"/></title>
</head>
<!-- ======== @Region: body ======== -->
  <body class="page page-login">
    <a href="#content" class="sr-only">Skip to content</a> 
    <tiles:insertAttribute name="header" />
    <tiles:insertAttribute name="body" />
<!-- FOOTER -->
	<tiles:insertAttribute name="footer" />
	<tiles:insertAttribute name="modal" />
</body>
</html>