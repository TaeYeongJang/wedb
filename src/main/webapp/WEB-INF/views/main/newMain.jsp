<%@page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>  
<sec:authentication var="user" property="principal" />
<sec:authentication var="details" property="details" /> 
<!DOCTYPE html>
<html lang="ko">

<head>
	<!-- include Header -->
	<c:set var='chkPageGroup' value='searchForm' />
	<%@include file="/WEB-INF/views/tile/include/default/includeHeader.jsp"%>
</head>

<body>

<div class="container-fluid">
	<div class="row">
		<div class="col-lg-1">
			<div>
			</div>
		</div>
	  	<div class="col-lg-9">지도</div>
	  	<div class="col-lg-2">정보</div>
	</div>
	
	<div class="row">
		<div class="col-md-1">.col-md-1</div>
		<div class="col-md-1">.col-md-1</div>
		<div class="col-md-1">.col-md-1</div>
		<div class="col-md-1">.col-md-1</div>
		<div class="col-md-1">.col-md-1</div>
		<div class="col-md-1">.col-md-1</div>
		<div class="col-md-1">.col-md-1</div>
		<div class="col-md-1">.col-md-1</div>
		<div class="col-md-1">.col-md-1</div>
		<div class="col-md-1">.col-md-1</div>
		<div class="col-md-1">.col-md-1</div>
		<div class="col-md-1">.col-md-1</div>
	</div>
</div>
<%-- 
<div class="wrapper">
    <!-- Logo, Header Navbar Include --> 
    <%@include file="/WEB-INF/views/tile/default/PageHeader.jsp"%>

    <!-- Left side column. contains sidebar -->
    <sec:authorize access="isAuthenticated()">
    	<%@include file="/WEB-INF/views/tile/include/menu/leftMenu.jsp"%>
    </sec:authorize> 
    <!-- /Left side column. contains sidebar -->

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" style="padding-left:210px;">
        <!-- Main content -->
        <div class="row">
        	<div class="col-md-8">.col-md-4</div>
  			<div class="col-md-4">.col-md-4</div>
        </div>
        <!-- /Main content -->
    </div>
	<!-- /.content-wrapper -->  
	<sec:authorize access="isAuthenticated()"> 
		<!-- Footer --> 
		<footer id="footerArea" class="main-footer" style="position: absolute; left: 0; bottom: 0; width: 100%;">
			<strong>COPYRIGHT&copy;2013 <a href="http://www.ekr.or.kr/" class="text-black" target="_blank">KRC</a></strong> ALL RIGHT RESERVED
			<div class="pull-right hidden-xs">
				<b>Version</b> 2.3.0 
			</div>
		</footer>
		<!-- /Footer --> 
	</sec:authorize>
	<sec:authorize access="isAnonymous()">
	<!-- Ghost Login Button -->  
		<div id="logoArea" class="main-footer" style="position:absolute; left:15px; top:15px;">
			<img src="<c:url value='/resources/wrms/image/rawris_logo.png'/>"/>
		</div>
	</sec:authorize> 
</div> --%>

<!-- TEST AREA  -->
<div id='final_object_view' style="position: fixed; left: 1200px; top: 10px; background-color: gray;"></div>
<!-- /TEST AREA  -->
</body>
</html>
