<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page import="com.saltware.enpass.client.EnpassClient" %>
<%
 	EnpassClient client = new EnpassClient(request, response);
	
	if(!client.doLogin()) return;
	
	String _enpass_id_ = (String) session.getAttribute("_enpass_id_"); 

	System.out.println("jsp _enpass_id_ : " + _enpass_id_);
%>
<!DOCTYPE html>
<html>
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

	<title>SSO 로그인 | WRMS KRC</title>
	<link href="<c:url value='/resources/wrms/image/favicon.png'/>" rel="shortcut icon" type="image/x-icon">  
	<link rel="stylesheet" href="<c:url value='/resources/external/skin/skin-rawris.css'/>" />
	<link rel="stylesheet" href="<c:url value='/resources/external/icheck/square/blue.css'/>" />
	<link rel="stylesheet" href="<c:url value='/resources/external/bootstrap/css/bootstrap.css"'/>" />
	<link rel="stylesheet" href="<c:url value='/resources/wrms/css/login.css'/>" />
	
	<script src="<c:url value='/resources/external/jquery/jquery-2.2.3.min.js'/>"></script>  
	<script src="<c:url value='/resources/external/bootstrap/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/resources/external/datatables/js/jquery.dataTables.min.js'/>"></script>
    <script src="<c:url value='/resources/external/datatables/js/dataTables.bootstrap.min.js'/>"></script>
	<script src="<c:url value='/resources/external/sha/sha512.js'/>"></script>  
	<script src="<c:url value='/resources/wrms/js/wrmsUtils.js'/>"></script>
	<script src="<c:url value='/resources/wrms/js/login.js?v=1.0'/>"></script>
	
	<script>
	$(function() {	
		$("#pw").val(rawrisGetDecriptStr($("#id").val()));
		$("#org_pw").val($("#id").val());
		
		$('#loginform').submit();	
	});
	</script>
</head>
<body>
<div id="container">
<form name="form" method="post" action="<c:url value='/loginProcess'/>" id="loginform" class="loginForm">
	<input type="hidden" name="id" id="id" value="<%=_enpass_id_%>">
	<input type="hidden" name="pw" id="pw">
	<input type="hidden" name="org_pw" id="org_pw">
	<input type="hidden" name="loginType" id="loginType" value="E">
</form>
</div>

</body>
</html>
