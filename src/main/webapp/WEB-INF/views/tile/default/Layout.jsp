<%@ page  contentType="text/html;" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head> 
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
	    <meta http-equiv="Content-Script-Type" content="text/javascript" />
	    <meta http-equiv="Content-Style-Type" content="text/css" />
	    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title><t:insertAttribute name="title" /></title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
	    <link rel="stylesheet" href="<c:url value='/resources/lib/select2/css/select2.min.css'/>">
		<link rel="stylesheet" href="<c:url value='/resources/lib/skin/css/skin-rawris.css'/>"/>
	    <link rel="stylesheet" href="<c:url value='/resources/lib/icheck/flat/blue.css'/>"> 
	    <link rel="stylesheet" href="<c:url value='/resources/lib/jquery.ui/css/jquery-ui.css'/>">
	    <link rel="stylesheet" href="<c:url value='/resources/lib/pqgrid/css/pqgrid.min.css'/>"> 
		<link rel="stylesheet" href="<c:url value='/resources/lib/pqgrid/css/pqgrid.css'/>"> 
	       
	    <script type="text/javascript" src="<c:url value='/resources/lib/jquery/jquery-2.2.3.min.js'/>"></script>
	    <script type="text/javascript" src="<c:url value='/resources/lib/jquery.ui/js/jquery-ui.min.js'/>"></script>
	    <script type="text/javascript" src="<c:url value='/resources/lib/bootstrap-3.3.2-dist/js/bootstrap.min.js'/>"></script>
	    <script type="text/javascript" src="<c:url value='/resources/lib/select2/js/select2.full.min.js'/>"></script> 
	    <script type="text/javascript" src="<c:url value='/resources/lib/daterangepicker/js/daterangepicker.js'/>"></script> 
	    <!-- script type="text/javascript" src="<c:url value='/resources/lib/dist/js/app.min.js'/>"></script -->
	    <script type="text/javascript" src="<c:url value='/resources/lib/jquery.datatable/jquery.dataTables.min.js'/>"></script>
	    <!-- script type="text/javascript" src="<c:url value='/resources/lib/jquery.datatable/dataTables.bootstrap.min.js'/>"></script -->
	    
	    <script type="text/javascript" src="<c:url value='/resources/lib/zingchart/js/zingchart.min.js'/>"></script> 
		<script type="text/javascript" src='<c:url value="/resources/js/utils/sha512.js"/>'></script>
		<script type="text/javascript" src='<c:url value="/resources/js/utils/kutil.js?v=1.01"/>'></script>
		<script type="text/javascript" src='<c:url value="/resources/js/utils/commonUtils.js"/>'></script> 
	</head>
	<body> 
	  <div id="header">
	  	<t:insertAttribute name="header" />
	  </div> 
	  <div id="script">
	  	<t:insertAttribute name="script" />
	  </div> 
	  <div id="nav">
	  	<t:insertAttribute name="nav" />
	  </div>  
	  <div id="contents">
	  	<t:insertAttribute name="contents" /> 
	  </div>  
	  <div id="footer">
	  	<t:insertAttribute name="footer" />
	  </div> 
	  
	</body>
</html>