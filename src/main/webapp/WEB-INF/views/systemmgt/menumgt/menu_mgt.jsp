<%@page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %> 
<sec:authentication var="details" property="details" />
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

	<title></title> 
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/font/font-awesome/css/font-awesome.min.css'/> "> 
	<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/select2/select2.min.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/skin/skin-rawris.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/icheck/flat/blue.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/jquery.ui/css/jquery-ui.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/jquery.ui/css/jquery-ui.css'/>" />
	
	<script src="<c:url value='/resources/external/jquery/jQuery-2.1.4.min.js'/>"></script> 
	<script src="<c:url value='/resources/external/jquery.ui/js/jquery-ui.min.js'/>"></script> 
	<script src="<c:url value='/resources/external/jquery.filedownload/js/jquery.fileDownload.js'/>"></script>
	<script src="<c:url value='/resources/external/jquery.block.ui/jquery.blockUI.js'/>"></script>
    <script src="<c:url value='/resources/external/bootstrap/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/resources/external/select2/select2.full.min.js'/>"></script>
    <script src="<c:url value='/resources/external/daterangepicker/daterangepicker.js'/>"></script>
    <script src="<c:url value='/resources/external/dist/app.min.js'/>"></script>
    <script src="<c:url value='/resources/external/datatables/js/jquery.dataTables.min.js'/>"></script>
    <script src="<c:url value='/resources/external/datatables/js/dataTables.bootstrap.min.js'/>"></script>
    <script src="<c:url value='/resources/external/zingchart/js/zingchart.min.js'/>"></script>
	<script>ZC.LICENSE = ['27e8d67301e3d716acfc9e1287a15f29'];</script> 
    <script src="<c:url value='/resources/external/moment/js/moment.min.js'/> "></script>
	    
	<script src="<c:url value='/resources/wrms/js/wrmsUtils.js'/>"></script> 
	<script src="<c:url value='/resources/external/sha/sha512.js'/>"></script> 
	
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]--> 
	<script type="text/javascript">
	
	var searchConditionObj ;
	var sqlMapper = "rawris.wrms.regist.menummgt.menu_mgt.";
	$(document).ready(function(){ 
		  
	});
	 
</script> 
</head>
<body class="hold-transition skin-rawris sidebar-mini">
	   
</body>
</html>