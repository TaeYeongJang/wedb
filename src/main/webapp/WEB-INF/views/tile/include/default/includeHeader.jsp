<%@ taglib prefix="fmt"   uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="today" class="java.util.Date"/>
<fmt:formatDate value="${today}" pattern="yyyyMMddHHmm" var="nowDate"/>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Bootstrap, a sleek, intuitive, and powerful mobile first front-end framework for faster and easier web development.">
	<meta name="keywords" content="HTML, CSS, JS, JavaScript, framework, bootstrap, front-end, frontend, web development">
	<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">

	<title></title>
	
	
	<script type="text/javascript">
		var searchConditionObj 	= {
				uBcd		: '${details.level_buseo_code}'
			,	uBlvl		: Number('${details.buseo_level}')
			,	uBorg		: '${details.orgin_buseo_code}'
			,	uId			: '${user}'
			,	s_type		: 'gisMain'
	    };
	</script>
	
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/font/font-awesome/css/font-awesome.min.css'/> "> 
	<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/select2/select2.min.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/icheck/flat/blue.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/skin/skin-rawris.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/jquery.ui/css/jquery-ui.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/bootstrap/css/bootstrap.css'/>" />
	<!-- / CSS -->

	<!-- JS from out -->
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
	<script src="<c:url value='/resources/external/jquery.number/jquery.number.min.js'/>"></script> 
	<script src="<c:url value='/resources/external/sha/sha512.js'/>"></script> 
	<!-- / JS from out -->
	
	<!-- JS in -->
	<script src="<c:url value='/resources/wrms/js/wrmsUtils.js?'><c:param name="v" value="${nowDate}"/></c:url>"></script> 
	<script src="<c:url value='/resources/wrms/js/local/leftMenu.js?'><c:param name="v" value="${nowDate}"/></c:url>"></script>
	<!-- / JS in --> 

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->